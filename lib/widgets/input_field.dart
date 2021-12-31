import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Function onTap;
  final Function onChange;
  final TextEditingController controller;
  final Function validator;
  final Function onSaved;
  final String hintText;
  final String labelText;
  final bool readOnly;
  final FocusNode focusNode;
  final double radius;
  final TextInputType keyboardType;
  final bool isPassword;
  final Key key;
  final bool isRadiusBorder;

  InputField({
    this.onTap,
    this.onChange,
    this.validator,
    this.onSaved,
    this.keyboardType,
    this.radius,
    this.key,
    this.isPassword = false,
    this.controller,
    this.isRadiusBorder,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      readOnly: readOnly ?? false,
      controller: controller,
      onTap: onTap,
      onSaved: onSaved,
      keyboardType: keyboardType,
      onChanged: onChange,
      validator: validator,
      focusNode: focusNode,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: isRadiusBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              )
            : null,
      ),
    );
  }
}
