import 'dart:convert';
import 'dart:async'; // Adicionado para usar Timer
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://apiescalonador2-production.up.railway.app';

class Gant extends StatefulWidget {
  final List<Map<String, dynamic>> dadosProcessos;

  const Gant({super.key, required this.dadosProcessos});

  @override
  _GantState createState() => _GantState();
}

class _GantState extends State<Gant> {
  String _selectedButton = '';
  double _speedFactor = 1.0;
  bool isLoading = true;
  Map<String, dynamic> results = {
    'FIFO': 0,
    'SJF': 0,
    'RR': 0,
    'EDF': 0,
  };
  String errorMessage = '';
  List<List<int>> selectedData = [];
  int currentColumn = 0;
  Timer? _timer;

  void _handleButtonPress(String buttonText) async {
    setState(() {
      _selectedButton = buttonText;
      selectedData = [];
      isLoading = true;
      errorMessage = '';
    });

    try {
      final requestPayload = widget.dadosProcessos;
      Map<String, dynamic> response;
      // Map<String, dynamic> response2;

      switch (buttonText) {
        case "FIFO":
          response = await postToEndpoint('/fifo/submit', requestPayload);
          // response2 = await postToEndpoint('/fifo/submit', requestPayload);
          break;
        case "SJF":
          response = await postToEndpoint('/sjf/submit', requestPayload);
          break;
        case "RR":
          response = await postToEndpoint('/rr/submit', requestPayload);
          break;
        case "EDF":
          response = await postToEndpoint('/edf/submit', requestPayload);
          break;
        default:
          response = {};
      }

      setState(() {
        results[buttonText] = response['turnaround'];
        selectedData = List<List<int>>.from(
          response['grafico'].map((item) => List<int>.from(item)),
        );

        isLoading = false;
        currentColumn = 0; // Resetar a coluna atual
        startSampling(); // Iniciar o processo de amostragem
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Erro ao obter dados: $e';
        isLoading = false;
      });
    }
  }

  Future<Map<String, dynamic>> postToEndpoint(
      String endpoint, dynamic body) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
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

  void startSampling() {
    _timer?.cancel();
    _timer = Timer.periodic(
      Duration(milliseconds: (1000 ~/ _speedFactor).toInt()),
      (Timer t) {
        setState(() {
          currentColumn++;
          if (currentColumn >= selectedData[0].length) {
            _timer
                ?.cancel(); // Para o timer quando todas as colunas foram exibidas
          }
        });
      },
    );
  }

  void updateSamplingSpeed(double newSpeed) {
    setState(() {
      _speedFactor = newSpeed;
    });
    startSampling(); // Reinicia o timer com a nova velocidade
  }

  void resetGrid() {
    setState(() {
      currentColumn = 0;
      startSampling(); // Reinicia o grid desde o começo
    });
  }

  Color getColorForValue(int value) {
    switch (value) {
      case 0:
        return Colors.yellow;
      case 1:
        return Colors.green;
      case 9:
        return Colors.grey;
      case 3:
        return Colors.red;
      default:
        return Colors.brown;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color fundo = Color(0xFF131F24);
    const Color rosadestaque = Color(0xFFFF2D55);
    const Color branco = Color(0xFFE5E5E5);
    const Color verde = Color(0xFF34C759);
    const Color cinza = Color(0xFF8E8E93);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton("FIFO", cinza, verde, fundo, branco,
                    _selectedButton == "FIFO"),
                _buildButton("SJF", cinza, verde, fundo, branco,
                    _selectedButton == "SJF"),
                _buildButton(
                    "RR", cinza, verde, fundo, branco, _selectedButton == "RR"),
                _buildButton("EDF", cinza, verde, fundo, branco,
                    _selectedButton == "EDF"),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: verde,
                      ),
                    )
                  : errorMessage.isNotEmpty
                      ? Center(
                          child: Text(
                            errorMessage,
                            style: GoogleFonts.asap(
                              fontSize: 20,
                              color: rosadestaque,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                for (int row = 0; row < 1; row++)
                                  Row(
                                    children: [
                                      // Row label
                                      Container(
                                        width: 24,
                                        height: 24,
                                        color: Colors.transparent,
                                        child: const Center(
                                          child: Text(
                                            '',
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                        ),
                                      ),

                                      // Row cells
                                      for (int col = 0;
                                          col < selectedData[0].length;
                                          col++)
                                        Container(
                                          width: 24,
                                          height: 24,
                                          margin: const EdgeInsets.all(2),
                                          color: Colors.transparent,
                                          child: Center(
                                            child: Text(
                                              '$col',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),

                                // Header row for column labels

                                // Grid rows with row labels
                                for (int row = 0;
                                    row < selectedData.length;
                                    row++)
                                  Row(
                                    children: [
                                      // Row label
                                      Container(
                                        width: 24,
                                        height: 24,
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Text(
                                            '${row + 1}',
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                        ),
                                      ),

                                      // Row cells
                                      for (int col = 0;
                                          col < selectedData[row].length;
                                          col++)
                                        Container(
                                          width: 24,
                                          height: 24,
                                          margin: const EdgeInsets.all(2),
                                          color: col <= currentColumn
                                              ? getColorForValue(
                                                  selectedData[row][col])
                                              : Colors.transparent,
                                        ),
                                    ],
                                  ),

                                const SizedBox(
                                  height: 40,
                                ),
                                if (_selectedButton.isNotEmpty &&
                                    results[_selectedButton] != null)
                                  Text(
                                    'Turnaround: ${results[_selectedButton]}',
                                    style: GoogleFonts.asap(
                                      fontSize: 40,
                                      color: rosadestaque,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                const SizedBox(height: 40),
                                const Text(
                                  "Velocidade de Amostragem",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Slider(
                                  activeColor: verde,
                                  value: _speedFactor,
                                  min: 0.5,
                                  max: 2.0,
                                  divisions: 3,
                                  label: '${_speedFactor.toStringAsFixed(1)}x',
                                  onChanged: (value) {
                                    updateSamplingSpeed(value);
                                  },
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: rosadestaque),
                                  onPressed: resetGrid,
                                  child: const Text(
                                    'Reset',
                                    style: TextStyle(color: branco),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String texto, Color cinza, Color verde, Color fundo,
      Color branco, bool isSelected) {
    return OutlinedButton(
      onPressed: () {
        _handleButtonPress(texto);
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: isSelected ? verde : cinza, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: isSelected ? verde : fundo,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: isSelected ? fundo : cinza,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
