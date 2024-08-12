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
        resizeToAvoidBottomInset: false, // Impede a mudança do tamanho do layout com o teclado
        appBar: AppBar(
          title: Center(child: Image.asset("assets/images/logo.png")),
          backgroundColor: const Color(0xFF131F24),
        ),
        backgroundColor: fundo,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0), // Adiciona um padding geral
              child: ListView(
                children: [
                  Text(
                    'Informe a quantidade de processos:',
                    style: GoogleFonts.asap(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFE5E5E5),
                    ),
                  ),
                  const SizedBox(height: 32.0),

                  // Espaçamento entre texto e campo de entrada
                  Row(
                    children: [
                      NumberInputWidget(),
                    ],
                  ),
                  const SizedBox(height: 70.0),

                  Text(
                    'Informe qual o quantum do processo:',
                    style: GoogleFonts.asap(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFE5E5E5),
                    ),
                  ),
                  const SizedBox(height: 32.0),

                  Row(
                    children: [
                      NumberInputWidget(),
                    ],
                  ),
                  const SizedBox(height: 70.0),

                  Text(
                    'Informe a sobrecarga do processo:',
                    style: GoogleFonts.asap(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFE5E5E5),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  
                  // Espaçamento entre texto e campo de entrada
                  Row(
                    children: [
                      NumberInputWidget(),
                    ],
                  ),

                  const SizedBox(height: 60.0),

                  ElevatedButton(
                    onPressed: () {
                      // Ação a ser executada quando o botão é pressionado
                      print('Botão pressionado!');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Cor de fundo do botão
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0), // Padding interno
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Bordas arredondadas
                      ),
                    ),
                    child: Text(
                      'Escalonar',
                      style: TextStyle(fontSize: 30.0), // Tamanho do texto
                    ),
                  )


                  

                  
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                child: Image.asset("assets/images/ilustracaop1.png", width: 120),
              ),
            ),
          ],
        ),
        
        
      ),
    );
  }
}
