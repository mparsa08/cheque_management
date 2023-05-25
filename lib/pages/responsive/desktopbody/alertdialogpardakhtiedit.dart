import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../controller/cheque_controller.dart';
import '../../../model/model_chek.dart';
import 'rowofalertdialogs/road.dart';
import 'rowofalertdialogs/road_bankname.dart';
import 'rowofalertdialogs/road_tarikh.dart';
import 'rowofalertdialogs/road_yadavari.dart';

class AlertDialogPardakhtiEdit extends StatefulWidget {
  String serialnum;
  String mablagh;
  String bankname;
  String pardakhtkonande;
  String tarikh;
  String tozihat;
  String phone;

  AlertDialogPardakhtiEdit({
    Key? key,
    required this.serialnum,
    required this.mablagh,
    required this.bankname,
    required this.pardakhtkonande,
    required this.tarikh,
    required this.tozihat,
    required this.phone,
  }) : super(key: key);

  @override
  State<AlertDialogPardakhtiEdit> createState() =>
      _AlertDialogPardakhtiEditState();
}

class _AlertDialogPardakhtiEditState extends State<AlertDialogPardakhtiEdit> {
  final ChequeController _chequeController = Get.find<ChequeController>();

  updateDatatoDataBasePardakhti() async {
    final cheque = Cheque(
      serial: int.parse(controllerSerial.text),
      mablagh: int.parse(controllerMablagh.text),
      bankname: controllerBank.text,
      pardakhtkonande: controllerPardakhtkonande.text,
      tarikh: controllerTarikh.text,
      tozihat: controllerTozihat.text,
      type: 'pardakhti',
      phonenumber: controllerPhone.text,
    );
    await _chequeController.updateCheque(cheque);
  }

  //switch 0=no notfication , 1=6hour notif , 2 = 24hour notif
  int switchYadavari = 0;

  //controllers
  TextEditingController controllerSerial = TextEditingController(text: '');

  TextEditingController controllerTarikh =
      TextEditingController(text: Jalali.now().formatCompactDate());

  TextEditingController controllerMablagh = TextEditingController(text: '');

  TextEditingController controllerPardakhtkonande =
      TextEditingController(text: '');

  TextEditingController controllerPhone = TextEditingController(text: '');
  TextEditingController controllerBank = TextEditingController(text: '');

  TextEditingController controllerTozihat = TextEditingController(text: '');

  @override
  void initState() {
    controllerSerial.text = widget.serialnum;
    controllerMablagh.text = widget.mablagh;
    controllerPardakhtkonande.text = widget.pardakhtkonande;
    controllerTarikh.text = widget.tarikh;
    controllerPhone.text = widget.phone;
    controllerTozihat.text = widget.tozihat;
    controllerBank.text = widget.bankname;

    super.initState();
  }

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
                          'ویرایش چک پرداختی',
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
                              enabled: false,
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
          onPressed: () {
            _chequeController.deleteCheque(int.parse(widget.serialnum));
            Navigator.pop(context);
          },
          child: const Text('حذف'),
        ),
        ElevatedButton(
          onPressed: () {
            updateDatatoDataBasePardakhti();
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
