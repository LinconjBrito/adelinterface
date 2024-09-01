import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// Endereço base da API
const String baseUrl = 'https://apiescalonador2-production.up.railway.app';

class Faster extends StatefulWidget {
  final List<Map<String, dynamic>> jsonData;
  const Faster({super.key, required this.jsonData});

  @override
  _FasterState createState() => _FasterState();
}

class _FasterState extends State<Faster> {
  bool isLoading = true;
  Map<String, dynamic> results = {
    'FIFO': 0,
    'SJF': 0,
    'RR': 0,
    'EDF': 0,
  };
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Pegando o JSON que vem como argumento
      final requestPayload = widget.jsonData;

      // Realizar requisições POST e obter resultados
      final fifoResponse = await postToEndpoint('/fifo/submit', requestPayload);
      final sjfResponse = await postToEndpoint('/sjf/submit', requestPayload);
      final rrResponse = await postToEndpoint('/rr/submit', requestPayload);
      final edfResponse = await postToEndpoint('/edf/submit', requestPayload);

      // Atualizar o estado com os resultados exatos retornados pela API
      setState(() {
        results = {
          'FIFO': fifoResponse['turnaround'],
          'SJF': sjfResponse['turnaround'],
          'RR': rrResponse['turnaround'],
          'EDF': edfResponse['turnaround'],
        };
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Erro ao obter dados: $e';
        isLoading = false;
      });
    }
  }

  // Função para realizar uma requisição POST para qualquer endpoint
  Future<Map<String, dynamic>> postToEndpoint(
      String endpoint, dynamic body) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Falha ao carregar dados. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color fundo = Color(0xFF131F24);
    final Color rosadestaque = Color(0xFFFF2D55);
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
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '"Faster - Seus resultados mais rápido."',
              style: GoogleFonts.asap(
                fontSize: 25,
                color: branco,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 20),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : errorMessage.isNotEmpty
                  ? Center(
                      child: Text(errorMessage,
                          style: TextStyle(color: Colors.red)))
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'FIFO',
                              style: GoogleFonts.asap(
                                fontSize: 30,
                                color: amarelo,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'SJF',
                              style: GoogleFonts.asap(
                                fontSize: 30,
                                color: amarelo,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              results['FIFO']?.toString() ?? '0',
                              style: GoogleFonts.asap(
                                fontSize: 70,
                                color: verde,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              results['SJF']?.toString() ?? '0',
                              style: GoogleFonts.asap(
                                fontSize: 70,
                                color: verde,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'RR',
                              style: GoogleFonts.asap(
                                fontSize: 30,
                                color: amarelo,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'EDF',
                              style: GoogleFonts.asap(
                                fontSize: 30,
                                color: amarelo,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              results['RR']?.toString() ?? '0',
                              style: GoogleFonts.asap(
                                fontSize: 70,
                                color: verde,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              results['EDF']?.toString() ?? '0',
                              style: GoogleFonts.asap(
                                fontSize: 70,
                                color: verde,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/ilustracaop2.png",
                              width: 150),
                        ),
                      ],
                    ),
        ],
      ),
    );
  }
}
