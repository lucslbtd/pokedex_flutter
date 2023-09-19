import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class PokeReaderScreen extends StatefulWidget {
  PokeReaderScreen(this.doc, {super.key});
  QueryDocumentSnapshot doc;

  @override
  State<PokeReaderScreen> createState() => _PokeReaderScreenState();
}

class _PokeReaderScreenState extends State<PokeReaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.doc['name']),
            Text(widget.doc['id']),
            Text(widget.doc['type']),
          ],
        ),
      ),
    );
  }
}
