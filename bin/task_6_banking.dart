import 'package:hw_flutter/task_6_banking.dart';

void main(List<String> arguments) {
  final ourBank = Bank();

  final firstAccId = ourBank.addAccount("Ilia");
  ourBank.safeOperation(AddMoney(ourBank, 1000, firstAccId));

  final secondAccId = ourBank.addAccount("AnotherMeh");
  ourBank.safeOperation(AddMoney(ourBank, 5000, secondAccId));

  ourBank.safeOperation(PrintAccountData(ourBank, firstAccId));
  ourBank.safeOperation(PrintAccountData(ourBank, secondAccId));

  ourBank.safeOperation(WithdrawMoney(ourBank, 500, firstAccId));
  ourBank.safeOperation(PrintAccountData(ourBank, firstAccId));
  ourBank.safeOperation(PrintAccountData(ourBank, secondAccId));

  ourBank.safeOperation(WithdrawMoney(ourBank, 500, firstAccId));
  ourBank.safeOperation(PrintAccountData(ourBank, firstAccId));
  ourBank.safeOperation(PrintAccountData(ourBank, secondAccId));

  ourBank.safeOperation(WithdrawMoney(ourBank, 1000, firstAccId));
  ourBank.safeOperation(PrintAccountData(ourBank, firstAccId));
  ourBank.safeOperation(PrintAccountData(ourBank, secondAccId));

  ourBank.safeOperation(TransferMoney(ourBank, 1500, secondAccId, firstAccId));
  ourBank.safeOperation(PrintAccountData(ourBank, firstAccId));
  ourBank.safeOperation(PrintAccountData(ourBank, secondAccId));
}
