import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GantPage extends StatefulWidget {
  const GantPage({super.key});

  @override
  State<GantPage> createState() => _GantPageState();
}

class _GantPageState extends State<GantPage> {
  @override
  Widget build(BuildContext context) {

    final Color fundo = Color(0xFF131F24);
    final Color rosadestaque = Color(0xFFFF2D55);
    final Color laranjadestaque = Color(0xFFFF9500);
    final Color branco = Color(0xFFE5E5E5);
    final Color verde = Color(0xFF34C759);
    final Color amarelo = Color(0xFFFFD74A);

    return Scaffold(
      backgroundColor: fundo,
      appBar: AppBar(
        shadowColor: rosadestaque,
        elevation: 1.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: rosadestaque),
        ),
        backgroundColor: fundo,
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Voltar",
            style: GoogleFonts.asap(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: rosadestaque,
            ),
          ),
        ),
      ),
      body: Column(
        
      ),

    );
  }
}