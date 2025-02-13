import 'package:flutter/material.dart';

class CardWithButtons extends StatelessWidget {
  static const TextStyle _cardTitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.50,
    color: Colors.black,
  );
  static const TextStyle _cardSubtitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.50,
    color: Colors.black54,
  );
  static const TextStyle _cardValueStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.40,
    color: Colors.black,
  );

  final String cardTitle;
  final String cardSubtitle;
  final String startValue;
  final String endValue;
  final List<Widget> actionButtons;

  const CardWithButtons({
    super.key,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.startValue,
    required this.endValue,
    required this.actionButtons,
  });

  Widget _buildRowWithSingleText(String text, TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [Text(text, style: style)],
    );
  }

  Widget _buildRowWithTwoTexts(String leftText, String rightText,
      TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftText, style: style),
        Text(rightText, style: style),
      ],
    );
  }

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
            _buildRowWithSingleText(cardTitle, _cardTitleStyle),
            const SizedBox(height: 5),
            _buildRowWithSingleText(cardSubtitle, _cardSubtitleStyle),
            const SizedBox(height: 5),
            _buildRowWithTwoTexts(startValue, endValue, _cardValueStyle),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: actionButtons,
            ),
          ],
        ),
      ),
    );
  }
}
