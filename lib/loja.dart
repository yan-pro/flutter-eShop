import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_yan/adicionar_roupa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

class LojaPage extends StatelessWidget {
  Widget _buildCatalog(QuerySnapshot snapshot) {
    return GridView.builder(
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index) {
        final doc = snapshot.docs[index];
        final user = FirebaseAuth.instance.currentUser?.displayName;
        if (doc["nome"] != null) {
          return (Scaffold(
            body: Card(
              shadowColor: Colors.red,
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: [Colors.redAccent, Colors.blue],
                          begin: Alignment.topCenter,
                        )),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "nome da roupa: ${doc["nome"]}",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Descrição: ${doc["descrição"]}",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                          "preço:${doc["preço"]} \nde:${user} \nContato: ${doc["telefone"]}",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ));
        }
        return (Scaffold(
          body: Card(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      doc["nome"],
                    ),
                  ],
                ),
                Text(doc["descrição"])
              ],
            ),
          ),
        ));
      },
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("area principal"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(seconds: 1),
                          transitionsBuilder:
                              (context, animation, animationTime, child) {
                            return ScaleTransition(
                                scale: animation,
                                child: child,
                                alignment: Alignment.topRight);
                          },
                          pageBuilder: (context, animation, animationTime) {
                            return AddRoupa();
                          }));
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Card(
          child: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("roupas").snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) return LinearProgressIndicator();
                  return Expanded(child: _buildCatalog(snapshot.data));
                }),
          ),
        ),
      ),
    );
  }
}
