// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  // get date and convert to jalali
  Jalali j = Jalali.now();
  //switch 0=no notfication , 1=6hour notif , 2 = 24hour notif
  int switchYadavari = 0;
  //controllers
  TextEditingController? controllerSerial;
  TextEditingController? controllerTarikh;
  TextEditingController? controllerMablagh;
  static TextEditingController controllerBank = TextEditingController(text: '');
  TextEditingController? controllerPardakhtkonande;
  TextEditingController? controllerPhone;

  @override
  void initState() {
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
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  backgroundColor: Colors.deepPurple,
                  contentPadding: EdgeInsets.all(0),
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
                                    padding: EdgeInsets.all(8),
                                    child: Text(
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
                                padding: EdgeInsets.all(15),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.grey, width: 2),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RowOfAlertDialogTarikh(
                                            text: 'تاریخ چک',
                                            hinttext: 'تاریخ چک',
                                            controller: controllerTarikh),
                                        RowOfAlertDialog(
                                          text: 'سریال چک',
                                          hinttext: 'سریال چک',
                                          controller: controllerSerial,
                                        ),
                                        RowOfAlertDialog(
                                          text: 'مبلغ چک',
                                          hinttext: 'مبلغ چک',
                                          controller: controllerMablagh,
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
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
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
  const RowOfAlertDialog({
    Key? key,
    required this.text,
    required this.hinttext,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: Text(text)),
          Expanded(
            flex: 2,
            child: TextFormField(
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
  final TextEditingController? controller;
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
  TextEditingController? selectedDate =
      TextEditingController(text: Jalali.now().formatFullDate());

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
                      picked.toString() != selectedDate!.text) {
                    setState(() {
                      selectedDate!.text = picked.formatFullDate();
                    });
                  }
                },
                child: TextFormField(
                    controller: selectedDate,
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
    const PardakhtiContainer(),
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
  const PardakhtiContainer({
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
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[200],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('سریال چک'),
                            SizedBox(
                              height: 5,
                            ),
                            Text('مبلغ چک'),
                            SizedBox(
                              height: 5,
                            ),
                            Text('اسم شخص'),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text('لوگوبانک-نام بانک'),
                            SizedBox(
                              height: 5,
                            ),
                            Text('تاریخ چک'),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
            );
          },
        ),
      ),
    );
  }
}
