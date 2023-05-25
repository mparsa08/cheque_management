import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class RowOfAlertDialogTarikh extends StatefulWidget {
  final String text;
  final String hinttext;
  final TextEditingController controller;
  const RowOfAlertDialogTarikh({
    Key? key,
    required this.text,
    required this.hinttext,
    required this.controller,
  }) : super(key: key);

  @override
  State<RowOfAlertDialogTarikh> createState() => _RowOfAlertDialogTarikhState();
}

class _RowOfAlertDialogTarikhState extends State<RowOfAlertDialogTarikh> {
  //date that users input

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: Text(widget.text)),
          Expanded(
            flex: 2,
            child: TextButton(
                onPressed: () async {
                  Jalali? picked = await showPersianDatePicker(
                      context: context,
                      initialDate: Jalali.now(),
                      firstDate: Jalali(Jalali.now().year - 1),
                      lastDate: Jalali(1450, 9),
                      initialEntryMode: PDatePickerEntryMode.calendarOnly,
                      initialDatePickerMode: PDatePickerMode.year,
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            dialogTheme: const DialogTheme(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      });
                  if (picked != null &&
                      picked.toString() != widget.controller.text) {
                    setState(() {
                      widget.controller.text = picked.formatCompactDate();
                    });
                  }
                },
                child: TextFormField(
                    controller: widget.controller,
                    enabled: false,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ))),
          ),
        ],
      ),
    );
  }
}
