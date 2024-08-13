import 'package:flutter/material.dart';
import 'package:escalonadors0/widgets/inputs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:escalonadors0/pageprocessos.dart';

final Color fundo = Color(0xFF131F24);

void main() {
  runApp(const MeuEscalonador());
}

// Usei isso para conseguir mudar a tela quando o botão "Escalonar for clicado"

class MeuEscalonador extends StatelessWidget {
  const MeuEscalonador({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Inicio());
  }
}
      
      

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
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

                  Align(
                    alignment: Alignment.centerLeft, // Alinha o botão à esquerda
                    child: FractionallySizedBox(
                      widthFactor: 0.6,
                      child: ElevatedButton(
                        onPressed: () {
                          print('Botão pressionado!');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PageProcessos()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff34C759), // Cor de fundo do botão
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0), // Padding interno
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // Bordas arredondadas
                          ),
                          elevation: 5.0, // Sombreamento do botão
                          shadowColor: const Color.fromARGB(255, 0, 80, 11), // Cor da sombra
                        ),
                        child: Text(
                          'Escalonar',
                          style: GoogleFonts.asap(fontSize: 30.0, color: Color(0xFFE5E5E5), fontWeight: FontWeight.w800),
                          // Tamanho do texto
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                child: Image.asset("assets/images/ilustracaop1.png", width: 150),
              ),
            ),
          ],
        ),
      );
}}
      
      
