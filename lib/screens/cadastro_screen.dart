import 'package:flutter/material.dart';

class CadastroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var image = Image.asset("assets/logo.png", width: 200, height: 200,);
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [Center(child: image,)],),
    );
  }

}