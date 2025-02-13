import 'package:flutter/material.dart';

class CardWithButtons extends StatelessWidget {
  static const TextStyle _titleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.50,
    color: Colors.black,
  );
  static const TextStyle _subtitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.50,
    color: Colors.black54,
  );
  static const TextStyle _bottomTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.40,
    color: Colors.black,
  );

  final String title;
  final String subtitle;
  final String leftValue;
  final String rightValue;
  final List<Widget> buttons;

  const CardWithButtons(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.leftValue,
      required this.rightValue,
      required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(title, style: _titleStyle),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(subtitle, style: _subtitleStyle),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(leftValue, style: _bottomTextStyle),
                Text(rightValue, style: _bottomTextStyle)
              ]),
              ButtonBar(

                alignment: MainAxisAlignment.end,
                children: buttons,
              )
            ],
          )),
    );
  }
}
