import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBox extends StatelessWidget {
  const MessageBox(
      {super.key, required this.boxColor, required this.childWidget});

  final Widget childWidget;
  final Color? boxColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Center(
        child: NeuCard(
          cardHeight: MediaQuery.of(context).size.height * 0.15,
          cardColor: boxColor,
          child: Center(
            child: childWidget,
          ),
        ),
      ),
    );
  }
}
