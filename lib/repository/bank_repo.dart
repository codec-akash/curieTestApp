import 'package:curie_pay/model/bank.dart';

class BankRepo {
  Future<List<Banks>> loadBanks() async {
    List<Banks> banks;
    var res = [
      {"bank": "ICICI Bank", "pinLength": 4, "cardNumber": "4321"},
      {"bank": "SBI Bank", "pinLength": 6, "cardNumber": "5678"}
    ];
    banks = (res).map((e) => Banks.fromJson(e)).toList();
    return banks;
  }
}
