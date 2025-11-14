import 'package:flutter/material.dart';

class LeetLabElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final IconData? icon;

  const LeetLabElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.buttonStyle,
    this.textStyle,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: (icon == null)
          ? Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(color: Colors.white),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon),
                SizedBox(width: 8),
                Text(
                  text,
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium!.copyWith(color: Colors.white),
                ),
              ],
            ),
    );
  }
}
