import 'package:flutter/material.dart';

class Quesion extends StatefulWidget {
  final String? text;
  final String? text1;
  final String? goto;
  const Quesion({super.key, this.text, this.text1, this.goto});

  @override
  State<Quesion> createState() => _QuesionState();
}

class _QuesionState extends State<Quesion> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.text!,
          style: TextStyle(
            color: Color.fromRGBO(110, 106, 124, 1),
            fontSize: 14,
            fontWeight: FontWeight.w200,
          ),
        ),

        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(widget.goto!);
          },
          child: Text(
            widget.text1!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
