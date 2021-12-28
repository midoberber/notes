import 'package:flutter/material.dart';

class GenericTextField extends StatelessWidget {
  final String? initialValue;
  final bool? enable;
  final int? maxLength;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final Function(String)? onSave;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;
  final Color? color;
  final Function? onEditingComplete;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final Function()? onTap;

  const GenericTextField(
      {Key? key,
      this.initialValue,
      this.enable,
      this.maxLength,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSave,
      this.validator,
      this.onFieldSubmitted,
      this.controller,
      this.color,
      this.onEditingComplete,
      this.textInputAction,
      this.maxLines,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText:labelText,
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
