import 'package:flutter/material.dart';

class CustomObsecureTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? textcontroller;
  final Widget icon;
  final Color? textcolor;

  // ignore: prefer_typing_uninitialized_variables
  final validator;

  const CustomObsecureTextField(
      {super.key,
      required this.hint,
      this.textcontroller,
      required this.icon,
      this.textcolor,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textcontroller,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hint,
        hintStyle: TextStyle(color: textcolor),
        border: const OutlineInputBorder(borderSide: BorderSide()),
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
