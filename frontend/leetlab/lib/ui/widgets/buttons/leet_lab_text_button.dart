import 'package:flutter/material.dart';

class LeetLabLinkButton extends StatelessWidget {
  final String message;
  final String link;
  final VoidCallback onPressed;
  final TextStyle? messageTextStyle;
  final TextStyle? linkTextStyle;

  const LeetLabLinkButton({
    super.key,
    required this.message,
    required this.link,
    required this.onPressed,
    this.messageTextStyle,
    this.linkTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        GestureDetector(onTap: onPressed, child: Text(link)),
      ],
    );
  }
}
