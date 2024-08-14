import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Faster extends StatelessWidget {
  const Faster({super.key});

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

        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '"Faster - Seus resultados mais rápido."',
              style: GoogleFonts.asap(
                  fontSize: 25, color: branco, fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,  
            children: [
              Text(
                'FIFO',
                style: GoogleFonts.asap(
                    fontSize: 30, color: amarelo, fontWeight: FontWeight.w800),
              ),
              Text(
                'SJF',
                style: GoogleFonts.asap(
                    fontSize: 30, color: amarelo, fontWeight: FontWeight.w800),
              )
            ],
          ),
                    Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,  
            children: [
              Text(
                '4.2',
                style: GoogleFonts.asap(
                    fontSize: 70, color: verde, fontWeight: FontWeight.w900),
              ),
              Text(
                '3.1',
                style: GoogleFonts.asap(
                    fontSize: 70, color: verde, fontWeight: FontWeight.w900),
              )
            ],
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,           
            children: [
              Text(
                'RR',
                style: GoogleFonts.asap(
                    fontSize: 30, color: amarelo, fontWeight: FontWeight.w800),
              ),
              Text(
                'EDF',
                style: GoogleFonts.asap(
                    fontSize: 30, color: amarelo, fontWeight: FontWeight.w800),
              )
            ],
          ),
                    Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,  
            children: [
              Text(
                '5.8',
                style: GoogleFonts.asap(
                    fontSize: 70, color: verde, fontWeight: FontWeight.w900),
              ),
              Text(
                '8.4',
                style: GoogleFonts.asap(
                    fontSize: 70, color: verde, fontWeight: FontWeight.w900),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/ilustracaop2.png", width: 200),
          )
        ],
      ),
    );
  }
}
