import 'package:flutter/material.dart';
import 'package:todo/my_theme.dart';

class CustomTextFormField extends StatelessWidget {

  String text;
  bool isPassword;
  TextInputType keyboardType;
  TextEditingController controller;
  String? Function(String?)? myValidator;

  CustomTextFormField({
    required this.text,
    this.isPassword=false,
    this.keyboardType=TextInputType.text,
    required this.controller,
    required this.myValidator
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: isPassword,
        validator:myValidator ,
        controller: controller,
        keyboardType:TextInputType.text ,
        decoration: InputDecoration(
            label: Text(text),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: MyTheme.primaryLightColor,
              width: 3
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: MyTheme.primaryLightColor,
                width: 3
            ),

      ),

        ),
      ),
    );
  }
}
