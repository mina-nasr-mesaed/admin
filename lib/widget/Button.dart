import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    this.onTap,
    required this.text,
  });

  String text;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(158, 4, 4, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          height: 60,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
              ),
            ),
          )),
    );
  }
}
