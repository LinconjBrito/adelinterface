import 'package:escalonadors0/faster.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:escalonadors0/Gantpage.dart';

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



  void preencherProcessosJson(){
    processosJson.clear(); // Limpa a lista antes de preenchê-la novamente

    for (int i = 0; i < processos.length; i++){
      processosJson.add({
        "T_chegada": int.tryParse(chegadaControllers[i].text)??0,
        "T_exec": int.tryParse(execucaoControllers[i].text)??0,
        "Termino": 0,
        "Turnaround": 0,
        "Deadline": int.tryParse(deadlineControllers[i].text)??0,
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
    for (int i = 0; i < widget.quantidadeProcessos; i++){
      chegadaControllers.add(TextEditingController());
      execucaoControllers.add(TextEditingController());
      deadlineControllers.add(TextEditingController());
    }
  }

  @override
  void dispose(){
    //Libera os valores dos controladores
    for (var controller in chegadaControllers){
      controller.dispose();
    }
    for (var controller in execucaoControllers){
      controller.dispose();
    }
    for (var controller in deadlineControllers){
      controller.dispose();
    }
  }

  void adicionarProcesso() {
      setState(() {
        processos.add(processos.length);
        chegadaControllers.add(TextEditingController());
        execucaoControllers.add(TextEditingController());
        deadlineControllers.add(TextEditingController());
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
          Expanded(
            child: ListView.builder(
              itemCount: processos.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      width: 250,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
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
                                  'Processo ${index + 1}',
                                  style: GoogleFonts.asap(
                                    fontSize: 30,
                                    color: laranjadestaque,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.remove_circle,
                                    color: rosadestaque),
                                onPressed: () => removerProcesso(index),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Chegada:',
                                style: GoogleFonts.asap(
                                    fontSize: 20,
                                    color: branco,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 150,
                              child: TextField(
                                controller: chegadaControllers[index],
                                style: GoogleFonts.asap(
                                    fontSize: 20,
                                    color: const Color(0xffe5e5e5)),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xff373D49)),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Execução:',
                                style: GoogleFonts.asap(
                                    fontSize: 20,
                                    color: branco,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 150,
                              child: TextField(
                                controller: execucaoControllers[index],
                                style: GoogleFonts.asap(
                                    fontSize: 20,
                                    color: const Color(0xffe5e5e5)),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xff373D49)),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Deadline:',
                                style: GoogleFonts.asap(
                                    fontSize: 20,
                                    color: branco,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 150,
                              child: TextField(
                                controller: deadlineControllers[index],
                                style: GoogleFonts.asap(
                                    fontSize: 20,
                                    color: const Color(0xffe5e5e5)),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xff373D49)),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                ),
                              ),
                            ),
                          ),
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
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: verde, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0)),
                child: IconButton(
                  color: verde,
                  icon: const Icon(Icons.add),
                  onPressed: adicionarProcesso,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    preencherProcessosJson();
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GantPage(dadosProcessos: processosJson),
                      
                      
                      ),
                      
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: verde,
                    padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
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
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: amarelo, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0)),
                child: IconButton(
                  color: amarelo,
                  icon: const Icon(Icons.bolt),
                  onPressed: () {
                    preencherProcessosJson();
                    Navigator.push(context,
                    
                        MaterialPageRoute(builder: (context) => Faster(jsonData: processosJson,)));

                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
