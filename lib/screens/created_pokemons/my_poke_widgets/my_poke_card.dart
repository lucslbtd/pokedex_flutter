import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

Widget mypokeCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doc['name']),
            Text(doc['id']),
            Text(doc['type']),
          ],
        ),
      ));
}
