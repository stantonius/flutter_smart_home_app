import 'package:flutter/material.dart';

class ClickableCard extends StatefulWidget {
  final Function clickFunction;
  final String cardText;
  final icon;
  const ClickableCard(
      {required this.clickFunction,
      required this.cardText,
      required this.icon,
      Key? key})
      : super(key: key);

  @override
  State<ClickableCard> createState() => _ClickableCardState();
}

class _ClickableCardState extends State<ClickableCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(widget.cardText), widget.icon],
            ),
          ),
        ),
        onTap: () {
          widget.clickFunction();
        },
      ),
    );
  }
}
