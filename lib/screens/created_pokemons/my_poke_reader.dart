import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class PokeReaderScreen extends StatefulWidget {
  PokeReaderScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  _PokeReaderScreenState createState() => _PokeReaderScreenState();
}

class _PokeReaderScreenState extends State<PokeReaderScreen> {
  static User? user = FirebaseAuth.instance.currentUser;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.doc['name'];
    _typeController.text = widget.doc['type'];
  }

  void _updatePokemon() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('mypokes')
          .doc(widget.doc.id)
          .update({
        'name': _nameController.text,
        'type': _typeController.text,
      });
      Navigator.pop(context);
    } catch (error) {
      print('Falha ao editar o pokemon :( $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: isEditing
            ? TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                textAlign:
                    TextAlign.center, // Centralize o texto no campo de texto
              )
            : Text('${_nameController.text}',
                textAlign: TextAlign.center), // Centralize o texto no Text
        backgroundColor: Colors.redAccent,
        elevation: 0,
        centerTitle: true, // Centralize o título da AppBar
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centralize o conteúdo da coluna
          children: [
            isEditing
                ? TextFormField(
                    controller: _typeController,
                    decoration: InputDecoration(labelText: 'Type'),
                    textAlign: TextAlign
                        .center, // Centralize o texto no campo de texto
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tipo: ${_typeController.text}',
                        textAlign:
                            TextAlign.center, // Centralize o texto no Text
                      ),
                    ],
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isEditing ? null : _updatePokemon,
        child: Icon(Icons.save),
      ),
    );
  }
}
