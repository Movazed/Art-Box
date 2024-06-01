import 'package:flutter/material.dart';
import 'package:artbox/utils/onBoardingButtonClipper.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: OnBoardingButtonClipper(),
        child: Container(
          width: 80,
          height: 95,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF9F3CB2),
              Color(0xFFF26567),
            ], stops: [
              0.4,
              1.0,
            ]),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 25),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}