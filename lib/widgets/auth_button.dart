import 'package:flutter/material.dart';

import 'text_widget.dart';

class AuthButton extends StatelessWidget {
  AuthButton({
    Key? key,
    required this.fct,
    required this.buttonText,
    this.primary = Colors.white38,
    this.isLoading = false
  }) : super(key: key);
  final Function fct;
  final String buttonText;
  final Color primary;
  bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: primary, // background (button) color
          ),
          onPressed: isLoading ? null : () {
            fct();
            // _submitFormOnLogin();
          },
          child: TextWidget(
            text: buttonText,
            textSize: 18,
            color: Colors.white,
          )),
    );
  }
}
