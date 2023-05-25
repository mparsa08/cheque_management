import 'package:flutter/material.dart';

class RowOfAlertDialog extends StatelessWidget {
  final String text;
  final String hinttext;
  final TextEditingController? controller;
  final bool validation;
  final bool enabled;
  const RowOfAlertDialog(
      {Key? key,
      required this.text,
      required this.hinttext,
      required this.controller,
      this.validation = false,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: Text(text)),
          Expanded(
            flex: 2,
            child: TextFormField(
              enabled: enabled,
              validator: (value) {
                if (validation == true) {
                  if (value == null) {
                    return '* الزامی ';
                  } else {
                    return null;
                  }
                } else {
                  return null;
                }
              },
              controller: controller,
              decoration: InputDecoration(
                  hintText: hinttext,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
          )
        ],
      ),
    );
  }
}
