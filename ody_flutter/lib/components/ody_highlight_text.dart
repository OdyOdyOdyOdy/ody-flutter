import "package:flutter/material.dart";

class OdyHighlightText extends StatelessWidget {
  const OdyHighlightText({
    required this.text,
    required this.highlightText,
    required this.textStyle,
    required this.highlightStyle,
    super.key,
  });

  final String text;
  final String highlightText;
  final TextStyle textStyle;
  final TextStyle highlightStyle;

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> spans = [];
    final List<String> parts = text.split(highlightText);

    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i], style: textStyle));
      if (i < parts.length - 1) {
        spans.add(TextSpan(text: highlightText, style: highlightStyle));
      }
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}
