import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:escalonadors0/pageprocessos.dart';
import 'package:escalonadors0/widgets/inputs.dart';
import 'dart:async';

final Color fundo = Color(0xFF131F24);

void main() {
  runApp(const MeuEscalonador());
}

class MeuEscalonador extends StatelessWidget {
  const MeuEscalonador({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Inicio()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      body: Center(
        child: Image.asset(
          
          'assets/images/icon3.png', // Substitua pelo caminho do seu logo
          width: 200,
        ),
      ),
    );
  }
}

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int quantidadeProcessos = 0;
  int quantum = 0;
  int sobrecarga = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Image.asset("assets/images/logo.png")),
        backgroundColor: fundo,
      ),
      backgroundColor: fundo,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
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
                Row(
                  children: [
                    NumberInputWidget(
                      onValueChanged: (value) {
                        setState(() {
                          quantidadeProcessos = value;
                        });
                      },
                    ),
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
                    NumberInputWidget(
                      onValueChanged: (value) {
                        setState(() {
                          quantum = value;
                        });
                      },
                    ),
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
                Row(
                  children: [
                    NumberInputWidget(
                      onValueChanged: (value) {
                        setState(() {
                          sobrecarga = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 60.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageProcessos(
                              quantidadeProcessos: quantidadeProcessos,
                              quantum: quantum,
                              sobrecarga: sobrecarga,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff34C759),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 15.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5.0,
                        shadowColor: const Color.fromARGB(255, 0, 80, 11),
                      ),
                      child: Text(
                        'Escalonar',
                        style: GoogleFonts.asap(
                          fontSize: 30.0,
                          color: fundo,
                          fontWeight: FontWeight.w800,
                        ),
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
              child: Image.asset(
                "assets/images/ilustracaop1.png",
                width: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
