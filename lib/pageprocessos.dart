import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageProcessos extends StatelessWidget {

  final Color fundo = Color(0xFF131F24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton( icon: const Icon(Icons.arrow_back), onPressed: (){Navigator.pop(context);}, ),
        backgroundColor: Colors.green,
        title: TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Voltar'))
    ));
  }
}