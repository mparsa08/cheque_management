import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../controller/cheque_controller.dart';
import '../../../model/model_chek.dart';
import 'rowofalertdialogs/road.dart';
import 'rowofalertdialogs/road_bankname.dart';
import 'rowofalertdialogs/road_tarikh.dart';
import 'rowofalertdialogs/road_yadavari.dart';

class AlertDialogDaryafti extends StatelessWidget {
  final ChequeController _chequeController = Get.find<ChequeController>();
  saveDatatoDataBasePardakhti() async {
    final cheque = Cheque(
      serial: int.parse(controllerSerial.text),
      mablagh: int.parse(controllerMablagh.text),
      bankname: controllerBank.text,
      pardakhtkonande: controllerPardakhtkonande.text,
      tarikh: controllerTarikh.text,
      tozihat: controllerTozihat.text,
      type: 'daryafti',
      ispaid: 'false',
      phonenumber: controllerPhone.text,
    );
    await _chequeController.addCheque(cheque);
  }

  int isSerialRepeated() {
    int i = 0;
    for (i; i < _chequeController.chequelist.length; i++) {
      //data jadid vared nashode va bayad Update shavad
      if (controllerSerial.text ==
          _chequeController.chequelist[i]!.serial.toString()) {
        return 0;
      }
    }
    return 1;
  }

  //switch 0=no notfication , 1=6hour notif , 2 = 24hour notif
  int switchYadavari = 0;
  //controllers
  TextEditingController controllerSerial = TextEditingController(text: '');
  TextEditingController controllerTarikh =
      TextEditingController(text: Jalali.now().formatCompactDate());
  TextEditingController controllerMablagh = TextEditingController(text: '');
  static TextEditingController controllerBank = TextEditingController(text: '');
  TextEditingController controllerPardakhtkonande =
      TextEditingController(text: '');
  TextEditingController controllerPhone = TextEditingController(text: '');
  TextEditingController controllerTozihat = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      contentPadding: const EdgeInsets.all(0),
      content: Builder(
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return SizedBox(
            // should change on mobile view - make errors
            width: width - 400,
            height: height - 300,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          'ثبت چک دریافتی',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RowOfAlertDialogTarikh(
                                text: 'تاریخ چک',
                                hinttext: 'تاریخ چک',
                                controller: controllerTarikh),
                            RowOfAlertDialog(
                              text: 'سریال چک',
                              hinttext: 'سریال چک',
                              controller: controllerSerial,
                              validation: true,
                            ),
                            RowOfAlertDialog(
                              text: 'مبلغ چک',
                              hinttext: 'مبلغ چک',
                              controller: controllerMablagh,
                              validation: true,
                            ),
                            RowOfAlertDialogBankName(
                              text: 'بانک',
                              hinttext: 'بانک',
                              controller: controllerBank,
                            ),
                            RowOfAlertDialog(
                              text: 'پرداخت کننده',
                              hinttext: 'پرداخت کننده',
                              controller: controllerPardakhtkonande,
                              validation: true,
                            ),
                            RowOfAlertDialog(
                              text: 'تلفن',
                              hinttext: 'تلفن',
                              controller: controllerPhone,
                            ),
                            RowOfAlertDialogYadavari(
                                text: 'یاددآوری',
                                switchYadavari: switchYadavari)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('لغو'),
        ),
        ElevatedButton(
          onPressed: () {
            if (isSerialRepeated() == 1) {
              saveDatatoDataBasePardakhti();
              Navigator.pop(context);
            }
          },
          child: const Text('ثبت'),
        ),
      ],
    );
  }
}
