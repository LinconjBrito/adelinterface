import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NumberInputWidget();
  }
}



class NumberInputWidget extends StatefulWidget {
  @override
  _NumberInputWidgetState createState() => _NumberInputWidgetState();
}

class _NumberInputWidgetState extends State<NumberInputWidget> {
  final TextEditingController _controller = TextEditingController(text: "0");
  int _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFFF3B30), width: 2.0 ),
            borderRadius: BorderRadius.circular(50.0)
          ),
          child: IconButton(
            color: Color(0xFFFF3B30),
          icon: Icon(Icons.remove,),
          onPressed: () {
            setState(() {
              _currentValue = int.parse(_controller.text);
              if (_currentValue > 0) _currentValue--;
              _controller.text = _currentValue.toString();
            });
          },
        ),
        ),

        SizedBox(width: 22.0,),

        
        
        SizedBox(
          width: 120,
          child: TextField(
            style: GoogleFonts.asap(fontSize: 20, color: const Color(0xffe5e5e5) ),
            controller: _controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff373D49)),
                borderRadius: BorderRadius.circular(12.0)
              ),
              
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
            onChanged: (value) {
              setState(() {
                _currentValue = int.tryParse(value) ?? 0;
              });
            },
          ),
        ),
        
        SizedBox(width: 22.0,),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF34C759), width: 2.0 ),
            borderRadius: BorderRadius.circular(50.0)
          ),
          child: IconButton(
            color: Color(0xFF34C759),
            icon: const  Icon(Icons.add),
            onPressed: () {
              setState(() {
                _currentValue = int.parse(_controller.text);
                _currentValue++;
                _controller.text = _currentValue.toString();
              });
            },
          ),
        ),
      ],
    );
  }
}
