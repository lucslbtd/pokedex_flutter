import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class PokeReaderScreen extends StatefulWidget {
  PokeReaderScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  _PokeReaderScreenState createState() => _PokeReaderScreenState();
}

class _PokeReaderScreenState extends State<PokeReaderScreen> {
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
          .collection('MyPokemons')
          .doc(widget.doc
              .id) // Use widget.doc.id para obter a referência do documento atual
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
              )
            : Text('${_nameController.text}'),
        backgroundColor: Colors.redAccent,
        elevation: 0,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isEditing
                ? TextFormField(
                    controller: _typeController,
                    decoration: InputDecoration(labelText: 'Type'),
                  )
                : Text('Type: ${_typeController.text}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isEditing
            ? null
            : _updatePokemon, // Desabilite o botão quando não estiver em edição
        child: Icon(Icons.save),
      ),
    );
  }
}
