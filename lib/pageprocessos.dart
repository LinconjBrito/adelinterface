import 'package:escalonadors0/faster.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:escalonadors0/grafico.dart';

class PageProcessos extends StatefulWidget {
  int quantidadeProcessos;
  final int quantum;
  final int sobrecarga;

  PageProcessos({
    required this.quantidadeProcessos,
    required this.quantum,
    required this.sobrecarga,
  });

  @override
  _PageProcessosState createState() => _PageProcessosState();
}

class _PageProcessosState extends State<PageProcessos> {
  List<TextEditingController> chegadaControllers = [];
  List<TextEditingController> execucaoControllers = [];
  List<TextEditingController> deadlineControllers = [];
  List<int> processos = [];
  List<Map<String, int>> processosJson = [];

  void preencherProcessosJson() {
    processosJson.clear(); // Limpa a lista antes de preenchê-la novamente

    for (int i = 0; i < processos.length; i++) {
      processosJson.add({
        "T_chegada": int.tryParse(chegadaControllers[i].text) ?? 0,
        "T_exec": int.tryParse(execucaoControllers[i].text) ?? 0,
        "Termino": 0,
        "Turnaround": 0,
        "Deadline": int.tryParse(deadlineControllers[i].text) ?? 0,
        "Id": i
      });
    }
    processosJson.add({
      "qtd_processos": widget.quantidadeProcessos,
      "quantum": widget.quantum,
      "sobrecarga": widget.sobrecarga,
    });
  }

  @override
  void initState() {
    super.initState();
    processos = List.generate(widget.quantidadeProcessos, (index) => index);

    //Iniciar os controladores
    for (int i = 0; i < widget.quantidadeProcessos; i++) {
      chegadaControllers.add(TextEditingController());
      execucaoControllers.add(TextEditingController());
      deadlineControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    //Libera os valores dos controladores
    for (var controller in chegadaControllers) {
      controller.dispose();
    }
    for (var controller in execucaoControllers) {
      controller.dispose();
    }
    for (var controller in deadlineControllers) {
      controller.dispose();
    }

  }

  void adicionarProcesso() {
    setState(() {
      processos.add(processos.length);
      chegadaControllers.add(TextEditingController());
      execucaoControllers.add(TextEditingController());
      deadlineControllers.add(TextEditingController());
      widget.quantidadeProcessos = processos.length;
    });
  }

  void removerProcesso(int index) {
    setState(() {
      processos.removeAt(index);
      chegadaControllers[index].dispose();
      execucaoControllers[index].dispose();
      deadlineControllers[index].dispose();
      chegadaControllers.removeAt(index);
      execucaoControllers.removeAt(index);
      deadlineControllers.removeAt(index);

      widget.quantidadeProcessos = processos.length;
    });
  }

  @override
  Widget build(BuildContext context) {


    const Color laranjadestaque = Color(0xFFFF9500);
    const Color verde = Color(0xFF34C759);
    const Color amarelo = Color(0xFFFFD74A);
    const Color vermelho = Color.fromARGB(255, 219, 53, 53);
    const Color fundo = Color(0xFF131F24);
    const Color rosadestaque = Color(0xFFFF2D55);



    return Scaffold(
      backgroundColor: fundo,
      appBar: AppBar(
        shadowColor: rosadestaque,
        elevation: 1.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: rosadestaque),
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
          Expanded(
            child: ListView.builder(
              itemCount: processos.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: 250,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: laranjadestaque, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Text(
                                  'Processo ${index+1}',
                                  style: GoogleFonts.asap(
                                    fontSize: 30,
                                    color: laranjadestaque,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                iconSize: 30,
                                icon: const Icon(Icons.delete_forever_rounded,
                                    color: vermelho),
                                onPressed: () => removerProcesso(index),
                              ),
                            ],
                          ),
                          _textos('Chegada:'),
                          CustomTextField(controller: chegadaControllers[index]),
                          _textos('Execução:'),
                          CustomTextField(controller: execucaoControllers[index]),
                          _textos('Deadline:'),
                          CustomTextField(controller: deadlineControllers[index]),
                          
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  adicionarProcesso();
                },
                style: OutlinedButton.styleFrom(
                  minimumSize:
                      const Size(45, 45), // Garante que o botão seja exatamente 40x40
                  side: const BorderSide(color: verde, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.zero, // Remove o padding extra
                ),
                child: const Icon(
                  Icons.add,
                  color: verde,
                  size:
                      20, // Tamanho do ícone ajustado para caber dentro do botão
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {

                    preencherProcessosJson();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Gant(dadosProcessos: processosJson,),
                            
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: verde,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5.0,
                  ),
                  child: Text(
                    'Escalonar',
                    style: GoogleFonts.asap(
                      fontSize: 25.0,
                      color: fundo,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  preencherProcessosJson();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Faster(jsonData: processosJson,),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize:
                      const Size(45, 45), // Garante que o botão seja exatamente 45x45
                  side: BorderSide(color: amarelo, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.zero, // Remove o padding extra
                ),
                child: const Icon(
                  Icons.bolt,
                  color: amarelo,
                  size:
                      20, // Tamanho do ícone ajustado para caber dentro do botão
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}

Widget _textos(String text) {

  return Padding(
    padding: const EdgeInsets.only(left: 40.0),
    child: Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: GoogleFonts.asap(
            fontSize: 20,
            color: Color(0xFFE5E5E5),
            fontWeight: FontWeight.w500),
      ),
    ),
  );
}


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  CustomTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 150,
        child: TextField(
          controller: controller,
          style: GoogleFonts.asap(
            fontSize: 20,
            color: const Color(0xffe5e5e5),
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff373D49)),
              borderRadius: BorderRadius.circular(12.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }
}


