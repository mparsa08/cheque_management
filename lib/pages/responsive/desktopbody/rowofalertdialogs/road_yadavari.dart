import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RowOfAlertDialogYadavari extends StatelessWidget {
  final String text;

  int switchYadavari;
  RowOfAlertDialogYadavari({
    Key? key,
    required this.text,
    required this.switchYadavari,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: Text(text)),
          ToggleSwitch(
            initialLabelIndex: 0,
            totalSwitches: 3,
            customWidths: const [100, 150, 100],
            isVertical: MediaQuery.of(context).size.width > 1000 ? false : true,
            textDirectionRTL: true,
            activeBgColor: const [Colors.deepPurple],
            labels: const ['غیرفعال ', '6' + 'ساعت', 'روز قبل '],
            onToggle: (index) {
              switchYadavari = index!;
            },
          )
        ],
      ),
    );
  }
}
