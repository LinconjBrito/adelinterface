import 'package:flutter/material.dart';
import 'package:escalonadors0/widgets/inputs.dart';
import 'package:google_fonts/google_fonts.dart';

final Color fundo = Color(0xFF131F24);

void main() {
  runApp(MeuEscalonador());
}

class MeuEscalonador extends StatelessWidget {
  const MeuEscalonador({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Center(child: Image.asset("assets/images/logo.png")), backgroundColor: const Color(0xFF131F24),),
        backgroundColor: fundo,
        body: Padding(
          padding: const EdgeInsets.all(16.0), // Adiciona um padding geral
          child: ListView(

            children: [
              Text(
                'Informe a quantidade de processos:',
                style: GoogleFonts.asap(fontSize: 22, fontWeight: FontWeight.w600, color: const Color(0xFFE5E5E5) )
              ),
              const SizedBox(height: 32.0,),


               // Espaçamento entre texto e campo de entrada
              Row(
                children: [
                  NumberInputWidget(),
                ],
              ),

              const SizedBox(height: 85.0,),



              Text(
                'Informe qual o quantum do processo:',
                style: GoogleFonts.asap(fontSize: 22, fontWeight: FontWeight.w600, color: const Color(0xFFE5E5E5) ),
              ),
              const SizedBox(height: 32.0,),

              Row(
                children: [
                  NumberInputWidget(),
                ],
              ),
              const SizedBox(height: 85.0,),

              Text(
                'Informe a sobrecarga do processo:',
                style: GoogleFonts.asap(fontSize: 22, fontWeight: FontWeight.w600, color: const Color(0xFFE5E5E5) ),
              ),
              const SizedBox(height: 32.0,),
 // Espaçamento entre texto e campo de entrada
              Row(
                children: [
                  NumberInputWidget(),
                ],
              ),

              Container(
              child: Image.asset("assets/images/ilustracaop1.png", width: 20,) ,
            ),
            ],


            
          ),
        ),
        
        bottomNavigationBar: BottomAppBar(
          color: Color(0xff1C272C),
          child: Center(child: Text("Geral", style: GoogleFonts.asap(fontSize: 20.0, color: Color(0xffFF2D55), fontWeight: FontWeight.w600),),),),
      ),
    );
  }
}
