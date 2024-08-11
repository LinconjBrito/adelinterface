import 'package:flutter/material.dart';

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
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              _currentValue = int.parse(_controller.text);
              if (_currentValue > 0) _currentValue--;
              _controller.text = _currentValue.toString();
            });
          },
        ),
        SizedBox(
          width: 80,
          child: TextField(
            style: TextStyle(color: Color(0xff52656d)),
            controller: _controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _currentValue = int.tryParse(value) ?? 0;
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _currentValue = int.parse(_controller.text);
              _currentValue++;
              _controller.text = _currentValue.toString();
            });
          },
        ),
      ],
    );
  }
}
