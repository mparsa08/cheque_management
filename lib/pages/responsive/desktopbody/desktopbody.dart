// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../controller/cheque_controller.dart';
import 'alertdialogpardakhti.dart';
import 'maincontainer.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  // get date and convert to jalali
  Jalali j = Jalali.now();

  //database
  final ChequeController _chequeController = Get.put(ChequeController());

  static bool isLoading = false;

  readallcheques() async {
    await _chequeController.getCheque();
  }

  @override
  void initState() {
    readallcheques();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("${j.year}/${j.month}/${j.day}"),
                  ),
                ),
                const Text(
                  'مدیریت چک ها',
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.keyboard_arrow_right_rounded)),
              ],
            ),
          ),
          leading: const Align(
              alignment: Alignment.center, child: Icon(Icons.people_alt_sharp)),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: const MainContainer(),
      ),
    );
  }
}

DefaultTextStyle defaultTextStyle(context, String text) {
  return DefaultTextStyle(
    style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.bold,
        ),
    child: Text(text),
  );
}
