// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:modiriat_check/db/pardakhti_db.dart';
import 'package:modiriat_check/model/model_chek.dart';

import '../../controller/cheque_controller.dart';

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
  static List<Cheque?>? cheque;

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
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (BuildContext context) => Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialogPardakhti(),
              ),
            );
          },
        ),
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
            customWidths: [100, 150, 100],
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

class RowOfAlertDialogBankName extends StatefulWidget {
  final String text;
  final String hinttext;
  final TextEditingController controller;
  final List<String> iranianBanks = [
    'ملت ',
    'ملی ',
    'سینا ',
    'سپه ',
    'تجارت ',
    'رفاه کارگران ',
    'بلوبانک ',
  ];
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
                return ListTile(
                  title: Text(itemData),
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
                      widget.controller.text = picked.formatFullDate();
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

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  List bodyitems = <Widget>[
    PardakhtiContainer(),
    const Text('item2'),
    const Text('item3'),
  ];
  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.arrow_circle_up_outlined),
                      label: 'پرداختی'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'خانه'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.arrow_circle_down_outlined),
                      label: 'دریافتی'),
                ],
                onTap: (value) => setState(() {
                  _onItemTapped(value);
                }),
                currentIndex: selectedIndex,
              ),
            ),
          ],
        ),
        Expanded(child: bodyitems.elementAt(selectedIndex)),
      ],
    );
  }
}

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
            return _DesktopBodyState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _chequeController.chequelist.isEmpty
                    ? const Center(child: Text('چکی ثبت نشده!'))
                    : Obx(
                        (() => ListView.builder(
                              itemCount: _chequeController.chequelist
                                  .where(
                                      (element) => element!.type == 'pardakhti')
                                  .length,
                              itemBuilder: (context, index) {
                                //for show results by order of dates
                                final reversedIndex = _chequeController
                                        .chequelist
                                        .where((element) =>
                                            element!.type == 'pardakhti')
                                        .length -
                                    index -
                                    1;

                                return InkWell(
                                  onTap: (() async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AlertDialogPardakhtiEdit(
                                            serialnum: _chequeController
                                                .chequelist
                                                .where((element) =>
                                                    element!.type ==
                                                    'pardakhti')
                                                .elementAt(reversedIndex)!
                                                .serial
                                                .toString(),
                                            bankname: _chequeController
                                                .chequelist
                                                .where((element) =>
                                                    element!.type ==
                                                    'pardakhti')
                                                .elementAt(reversedIndex)!
                                                .bankname
                                                .toString(),
                                            mablagh: _chequeController
                                                .chequelist
                                                .where((element) =>
                                                    element!.type ==
                                                    'pardakhti')
                                                .elementAt(reversedIndex)!
                                                .mablagh
                                                .toString(),
                                            pardakhtkonande: _chequeController
                                                .chequelist
                                                .where((element) =>
                                                    element!.type ==
                                                    'pardakhti')
                                                .elementAt(reversedIndex)!
                                                .pardakhtkonande
                                                .toString(),
                                            phone: _chequeController.chequelist
                                                .where((element) =>
                                                    element!.type ==
                                                    'pardakhti')
                                                .elementAt(reversedIndex)!
                                                .phonenumber
                                                .toString(),
                                            tarikh: _chequeController.chequelist
                                                .where((element) =>
                                                    element!.type ==
                                                    'pardakhti')
                                                .elementAt(reversedIndex)!
                                                .tarikh
                                                .toString(),
                                            tozihat: _chequeController
                                                .chequelist
                                                .where((element) =>
                                                    element!.type ==
                                                    'pardakhti')
                                                .elementAt(reversedIndex)!
                                                .tozihat
                                                .toString(),
                                          )),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            28, 8, 28, 8),
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
                                                  Text(_chequeController
                                                      .chequelist
                                                      .where((element) =>
                                                          element!.type ==
                                                          'pardakhti')
                                                      .elementAt(reversedIndex)!
                                                      .serial
                                                      .toString()),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(_chequeController
                                                      .chequelist
                                                      .where((element) =>
                                                          element!.type ==
                                                          'pardakhti')
                                                      .elementAt(reversedIndex)!
                                                      .mablagh
                                                      .toString()),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(_chequeController
                                                      .chequelist
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(_chequeController
                                                      .chequelist
                                                      .where((element) =>
                                                          element!.type ==
                                                          'pardakhti')
                                                      .elementAt(reversedIndex)!
                                                      .tarikh
                                                      .toString()),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(_chequeController
                                                      .chequelist
                                                      .where((element) =>
                                                          element!.type ==
                                                          'pardakhti')
                                                      .elementAt(reversedIndex)!
                                                      .bankname
                                                      .toString()),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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

class AlertDialogPardakhti extends StatelessWidget {
  final ChequeController _chequeController = Get.find<ChequeController>();
  saveDatatoDataBasePardakhti() async {
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
      TextEditingController(text: Jalali.now().formatFullDate());
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

          return Container(
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
                          'ثبت چک پرداختی',
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
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (isSerialRepeated() == 1) {
              saveDatatoDataBasePardakhti();
              Navigator.pop(context);
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

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
      TextEditingController(text: Jalali.now().formatFullDate());

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

          return Container(
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

DefaultTextStyle defaultTextStyle(context, String text) {
  return DefaultTextStyle(
    style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.bold,
        ),
    child: Text(text),
  );
}
