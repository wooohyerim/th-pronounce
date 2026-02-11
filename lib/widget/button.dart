import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color borderColor, bgColor, textColor, iconColor;
  final VoidCallback? onTap;
  final IconData? icon;

  const Button({
    super.key,
    required this.text,
    required this.bgColor,
    this.borderColor = Colors.transparent,
    required this.textColor,
    this.onTap,
    this.icon,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(style: BorderStyle.solid, color: borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: iconColor),
                SizedBox(width: 8),
              ],
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
