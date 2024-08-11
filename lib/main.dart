import 'package:flutter/material.dart';
import 'package:escalonadors0/widgets/inputs.dart';

final Color fundo = Color(0xFF131f24);

void main() {
  runApp(MeuEscalonador());
}

class MeuEscalonador extends StatelessWidget {
  const MeuEscalonador({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: fundo,
        body: Padding(
          padding: const EdgeInsets.all(16.0), // Adiciona um padding geral
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Informe a quantidade de processos:',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 8), // Espaçamento entre texto e campo de entrada
              Row(
                children: [
                  NumberInputWidget(),
                ],
              ),
              const SizedBox(height: 16), // Espaçamento entre os grupos de elementos
              const Text(
                'Informe qual o quantum do processo:',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8), // Espaçamento entre texto e campo de entrada
              Row(
                children: [
                  NumberInputWidget(),
                ],
              ),
              const SizedBox(height: 16), // Espaçamento entre os grupos de elementos
              const Text(
                'Informe a sobrecarga do processo:',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 8), // Espaçamento entre texto e campo de entrada
              Row(
                children: [
                  NumberInputWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
