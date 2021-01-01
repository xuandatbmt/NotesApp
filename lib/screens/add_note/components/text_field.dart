import 'package:flutter/material.dart';
class AddingTextField extends StatelessWidget {
  final int maxLines;
  final String hintText;

  final ValueChanged<String> onChanged;
  const AddingTextField({
    Key key,
    this.hintText,
    this.maxLines,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hintText),
          onChanged: onChanged),
    );
  }
}
