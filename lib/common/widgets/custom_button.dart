import 'package:flutter/material.dart';
import 'package:watsapp/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.ontap, required this.text});

  final VoidCallback? ontap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: tabColor,
        minimumSize: const Size(double.infinity, 50)
      ),
    );
  }
}
