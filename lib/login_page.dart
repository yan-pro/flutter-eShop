import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'google_sign_in.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        color: Colors.white,
      ),
      Container(
        height: 200,
        width: 400,
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "bem vindo a loja d'yan \nas melhores roupas estao aqui ",
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
          ),
        ),
      ),
      Center(
          child: ElevatedButton.icon(
        icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
        style: ElevatedButton.styleFrom(
            primary: Colors.black, minimumSize: Size(250, 50)),
        label: Text("Entrar Com O Google"),
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.googleLogin();
        },
      ))
    ]));
  }
}
