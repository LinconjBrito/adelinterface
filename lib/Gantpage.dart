import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GantPage extends StatefulWidget {
  final List<Map<String, int>> dadosProcessos;
  const GantPage({super.key, required this.dadosProcessos});

  @override
  State<GantPage> createState() => _GantPageState();
}

class _GantPageState extends State<GantPage> {
  String _selectedButton = '';

  void _handleButtonPress(String buttonText) {
    setState(() {
      _selectedButton = buttonText; // Atualiza o botão selecionado
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color fundo = Color(0xFF131F24);
    final Color rosadestaque = Color(0xFFFF2D55);
    final Color laranjadestaque = Color(0xFFFF9500);
    final Color branco = Color(0xFFE5E5E5);
    final Color verde = Color(0xFF34C759);
    final Color amarelo = Color(0xFFFFD74A); // Definindo a cor amarela
    final Color cinza = Color(0xFF8E8E93);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton("FIFO", cinza, verde, _selectedButton == "FIFO"),
                _buildButton("SJF", cinza, verde, _selectedButton == "SJF"),
                _buildButton("RR", cinza, verde, _selectedButton == "RR"),
                _buildButton("EDF", cinza, verde, _selectedButton == "EDF"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color borderColor, Color textColor, bool isSelected) {
    return OutlinedButton(
      onPressed: () => _handleButtonPress(text),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: isSelected ? textColor : borderColor, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero, // Remove o padding extra
      ),
      child: Text(
        text,
        style: GoogleFonts.asap(
          fontSize: 15,
          color: isSelected ? textColor : borderColor, // Muda a cor do texto
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
