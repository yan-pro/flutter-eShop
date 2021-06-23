import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddRoupa extends StatefulWidget {
  @override
  _AddRoupaState createState() => _AddRoupaState();
}

class _AddRoupaState extends State<AddRoupa> {
  void _saveRoupa() {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    final nome = _nome.text;
    final price = _price.text;
    final description = _description.text;

    final telefone = _numero.text;

    FirebaseFirestore.instance.collection("roupas").add({
      'nome': nome,
      'preço': price,
      'descrição': description,
      'UID': uid,
      'hora': DateTime.now(),
      "telefone": telefone,
    });
  }

  var _nome = TextEditingController();

  var _price = TextEditingController();

  var _description = TextEditingController();

  var _numero = TextEditingController();

  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("adicionar roupa"),
        ),
        body: Card(
          child: Stack(children: [
            Container(
              color: Colors.blueGrey[200],
            ),
            Container(
              height: 70,
              width: 400,
              color: Colors.black,
              child: Center(
                  child: Text(
                "adicione seu produto abaixo",
                style: TextStyle(color: Colors.white),
              )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _nome,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "nome da roupa"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _price,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "preço da roupa"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _description,
                    decoration: InputDecoration(
                        hintText: "tamanho,cor,numero de contato,etc",
                        border: OutlineInputBorder(),
                        labelText: "descrição da roupa"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _numero,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: "numero de contato",
                        labelText: "contato",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23))),
                  ),
                ),
                TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: () {
                      _saveRoupa();
                      Navigator.of(context).pop();
                    },
                    child: Text("colocar a venda")),
              ],
            ),
          ]),
        ));
  }
}
