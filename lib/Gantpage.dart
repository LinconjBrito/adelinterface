import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GantPage extends StatefulWidget {
  final List<Map<String, int>> dadosProcessos;
  const GantPage({super.key, required this.dadosProcessos});

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dados dos Processos:',
              style: GoogleFonts.asap(
                fontSize: 25.0,
                color: branco,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.dadosProcessos.length,
                itemBuilder: (context, index) {
                  final processo = widget.dadosProcessos[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      processo.toString(),
                      style: GoogleFonts.asap(
                        fontSize: 18.0,
                        color: branco,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}