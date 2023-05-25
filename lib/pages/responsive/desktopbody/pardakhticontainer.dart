import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/cheque_controller.dart';
import '../../../db/pardakhti_db.dart';
import '../../../utils/iranbanknames.dart';
import 'alertdialogpardakhtiedit.dart';

class PardakhtiContainer extends StatelessWidget {
  final ChequeController _chequeController = Get.find<ChequeController>();
  PardakhtiContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 3),
            borderRadius: BorderRadius.circular(5)),
        child: FutureBuilder(
          future: BankDataBase.instance.readAllCheque(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return _chequeController.chequelist.isEmpty
                ? const Center(child: Text('چکی ثبت نشده!'))
                : Obx(
                    (() => ListView.builder(
                          itemCount: _chequeController.chequelist
                              .where((element) => element!.type == 'pardakhti')
                              .length,
                          itemBuilder: (context, index) {
                            //for show results by order of dates
                            final reversedIndex = _chequeController.chequelist
                                    .where((element) =>
                                        element!.type == 'pardakhti')
                                    .length -
                                index -
                                1;
                            // to make an instanse of Iranian Banks for showing names and logos
                            var iranbank = IranBank(
                                bankname: _chequeController.chequelist
                                    .where((element) =>
                                        element!.type == 'pardakhti')
                                    .elementAt(reversedIndex)!
                                    .bankname
                                    .toString());

                            // format number of mablagh to rial format

                            int numbermablagh = _chequeController.chequelist
                                .where(
                                    (element) => element!.type == 'pardakhti')
                                .elementAt(reversedIndex)!
                                .mablagh;

                            intl.NumberFormat numberFormat =
                                intl.NumberFormat.currency(
                              locale: 'fa_IR',
                              symbol: 'تومان',
                              decimalDigits: 0,
                            );
                            String formattedMablagh =
                                numberFormat.format(numbermablagh);

                            // format number of serial to rial format
                            int numberseial = _chequeController.chequelist
                                .where(
                                    (element) => element!.type == 'pardakhti')
                                .elementAt(reversedIndex)!
                                .serial;
                            intl.NumberFormat numberFormatserial =
                                intl.NumberFormat('', 'fa_IR');
                            String formattedSerial =
                                numberFormatserial.format(numberseial);

                            return InkWell(
                              onTap: (() async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: AlertDialogPardakhtiEdit(
                                        serialnum: _chequeController.chequelist
                                            .where((element) =>
                                                element!.type == 'pardakhti')
                                            .elementAt(reversedIndex)!
                                            .serial
                                            .toString(),
                                        bankname: _chequeController.chequelist
                                            .where((element) =>
                                                element!.type == 'pardakhti')
                                            .elementAt(reversedIndex)!
                                            .bankname
                                            .toString(),
                                        mablagh: _chequeController.chequelist
                                            .where((element) =>
                                                element!.type == 'pardakhti')
                                            .elementAt(reversedIndex)!
                                            .mablagh
                                            .toString(),
                                        pardakhtkonande: _chequeController
                                            .chequelist
                                            .where((element) =>
                                                element!.type == 'pardakhti')
                                            .elementAt(reversedIndex)!
                                            .pardakhtkonande
                                            .toString(),
                                        phone: _chequeController.chequelist
                                            .where((element) =>
                                                element!.type == 'pardakhti')
                                            .elementAt(reversedIndex)!
                                            .phonenumber
                                            .toString(),
                                        tarikh: _chequeController.chequelist
                                            .where((element) =>
                                                element!.type == 'pardakhti')
                                            .elementAt(reversedIndex)!
                                            .tarikh
                                            .toString(),
                                        tozihat: _chequeController.chequelist
                                            .where((element) =>
                                                element!.type == 'pardakhti')
                                            .elementAt(reversedIndex)!
                                            .tozihat
                                            .toString(),
                                      )),
                                );
                              }),
                              child: Column(
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(28, 8, 28, 8),
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue[200],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(formattedSerial),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                formattedMablagh,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(_chequeController.chequelist
                                                  .where((element) =>
                                                      element!.type ==
                                                      'pardakhti')
                                                  .elementAt(reversedIndex)!
                                                  .pardakhtkonande
                                                  .toString()),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(_chequeController.chequelist
                                                  .where((element) =>
                                                      element!.type ==
                                                      'pardakhti')
                                                  .elementAt(reversedIndex)!
                                                  .tarikh
                                                  .toString()),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: Image(
                                                      image: AssetImage(iranbank
                                                          .getimagepath()),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(_chequeController
                                                      .chequelist
                                                      .where((element) =>
                                                          element!.type ==
                                                          'pardakhti')
                                                      .elementAt(reversedIndex)!
                                                      .bankname
                                                      .toString()),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          height: 2,
                                          decoration: BoxDecoration(
                                            color: Colors.lightBlue[200],
                                          ),
                                          child: Container(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        )),
                  );
          },
        ),
      ),
    );
  }
}
