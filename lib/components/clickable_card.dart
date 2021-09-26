import 'package:flutter/material.dart';

class ClickableCard extends StatefulWidget {
  final Function clickFunction;
  final String cardText;
  const ClickableCard(
      {required this.clickFunction, required this.cardText, Key? key})
      : super(key: key);

  @override
  State<ClickableCard> createState() => _ClickableCardState();
}

class _ClickableCardState extends State<ClickableCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Card(
          child: Text(widget.cardText),
        ),
        onTap: () {
          widget.clickFunction();
        },
      ),
    );
  }
}
