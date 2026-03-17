import 'package:flutter/material.dart';
import 'package:otc_app/app.dart';
import 'package:pinput/pinput.dart';

class CodeInput extends StatelessWidget {
  CodeInput({super.key, required this.onCompleted, this.isBlack = true});

  late bool isBlack = true;

  final Function(String pin) onCompleted;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 24,
          color: Config.kTheme!.text1,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Config.kTheme!.text2, width: 0.8),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = isBlack
        ? defaultPinTheme.copyDecorationWith(
            // border: Border.all(color: context.appColors.primary),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xff28A1FF), width: 1.2),
          )
        : defaultPinTheme.copyDecorationWith(
            // border: Border.all(color: context.appColors.primary),
            borderRadius: BorderRadius.circular(8),
            color: Color(0xff5d4c30).withOpacity(0.1),
            border: Border.all(color: Colors.white, width: 1.2),
          );

    final submittedPinTheme = isBlack
        ? defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration?.copyWith(
              color: Colors.transparent,
              border: Border.all(color: Config.kTheme!.text2, width: 0.8),
            ),
          )
        : defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration?.copyWith(
              color: Color(0xff5d4c30).withOpacity(0.1),
              border: Border.all(color: Colors.white, width: 1.2),
            ),
          );

    return Pinput(
      length: 6,
      autofocus: true,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      validator: (s) {
        // return s == '2222' ? null : 'Pin is incorrect';
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      obscureText: true,
      onChanged: onCompleted,
      onCompleted: onCompleted,
    );
  }
}
