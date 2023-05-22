import 'package:get/get.dart';
import '../model/model_chek.dart';
import '../db/pardakhti_db.dart';

class ChequeController extends GetxController {
  final RxList chequelist = <Cheque>[].obs;

  Future<void> getCheque() async {
    final List<Cheque> cheques = await BankDataBase.instance.readAllCheque();
    chequelist.assignAll(cheques);
  }

  addCheque(Cheque cheque) async {
    await BankDataBase.instance.create(cheque);
    chequelist.add(cheque);
    getCheque();
  }

  deleteCheque(int? id) async {
    await BankDataBase.instance.deleteCheque(id);
    getCheque();
  }

  deletAllCheques() async {
    await BankDataBase.instance.deleteAllCheque();
    getCheque();
  }

  updateCheque(Cheque cheque) async {
    await BankDataBase.instance.updateCheque(cheque);
    getCheque();
  }
}
