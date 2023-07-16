import 'package:flutter/material.dart';
import 'package:modiriat_check/db/pardakhti_db.dart';
import 'package:modiriat_check/model/model_chek.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../controller/cheque_controller.dart';

class homecontainer extends StatefulWidget {
  homecontainer({super.key});

  @override
  State<homecontainer> createState() => _homecontainerState();
}

class _homecontainerState extends State<homecontainer> {
  final ChequeController _chequeController = Get.find<ChequeController>();
  late List<Cheque> cheque;
  Map<String, double> dataMap = {};

  refreshDavs() async {
    cheque = await BankDataBase.instance.readAllCheque();
  }

  @override
  void initState() {
    refreshDavs();
    dataMap.addAll({
      "چک های دریافتی": _chequeController.chequelist
          .where((element) => element!.type == 'daryafti')
          .length
          .toDouble(),
      "چک های پرداختی": _chequeController.chequelist
          .where((element) => element!.type == 'pardakhti')
          .length
          .toDouble(),
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 3),
              borderRadius: BorderRadius.circular(5)),
          child: PieChart(
            dataMap: dataMap,
          )),
    );
  }
}
