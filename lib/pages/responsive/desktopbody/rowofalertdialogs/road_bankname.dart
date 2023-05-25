import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../utils/iranbanknames.dart';

class RowOfAlertDialogBankName extends StatefulWidget {
  final String text;
  final String hinttext;
  final TextEditingController controller;
  final List<String> iranianBanks = iranianBanknames;
  RowOfAlertDialogBankName({
    Key? key,
    required this.text,
    required this.hinttext,
    required this.controller,
  }) : super(key: key);

  @override
  State<RowOfAlertDialogBankName> createState() =>
      _RowOfAlertDialogBankNameState();
}

class _RowOfAlertDialogBankNameState extends State<RowOfAlertDialogBankName> {
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
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                controller: widget.controller,
                decoration: InputDecoration(
                    hintText: widget.hinttext,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              itemBuilder: (BuildContext context, String itemData) {
                var iranbank = IranBank(bankname: itemData);
                return ListTile(
                  title: Text(itemData),
                  leading: SizedBox(
                    width: 30,
                    height: 30,
                    child: Image(
                      image: AssetImage(iranbank.getimagepath()),
                    ),
                  ),
                );
              },
              onSuggestionSelected: (suggestion) {
                widget.controller.text = suggestion;
              },
              suggestionsCallback: (String pattern) async {
                return widget.iranianBanks.where((option) =>
                    option.toLowerCase().contains(pattern.toLowerCase()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
