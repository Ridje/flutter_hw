class Bank {
  int _increment = 0;
  Map<int, Account> accounts = {};

  int addAccount(String owner) {
    _increment++;
    accounts.putIfAbsent(_increment, () => Account(owner, _increment));
    return _increment;
  }

  safeOperation(Command operation) {
    try {
      operation();
    } on AccountException catch (e) {
      print (e);
    }
  }


  _addMoney(int accountId, int amount) {
    final account = _checkAccountRegistered(accountId);

    account.amount += amount;
  }

  _printAccountInfo(int accountId) {
    final account = _checkAccountRegistered(accountId);

    print("Account #${account.id}, owner = ${account.owner}, balance = ${account.amount}");
  }

  _withdrawMoney(int accountId, int amount) {
    final account = _checkAccountRegistered(accountId);
    _checkInsufficientAmount(account, amount);
    account.amount -= amount;
  }

  _transferMoney(int from, int to, int amount) {
    final accountFrom = _checkAccountRegistered(from);
    final accountTo = _checkAccountRegistered(to);
    _checkInsufficientAmount(accountFrom, amount);

    accountFrom.amount -= amount;
    accountTo.amount += amount;
  }

  Account _checkAccountRegistered(accountId) {
    Account? account = accounts[accountId];

    if (account == null) {
      throw AccountNotFoundInOurBank(accountId);
    }

    return account;
  }

  void _checkInsufficientAmount(Account account, int requestedAmount) {
    if (account.amount < requestedAmount) {
      throw InsufficientFundsException(requestedAmount, account.id);
    }
  }
}

class Account {
  final String owner;
  final int id;
  int amount = 0;

  Account(this.owner, this.id);
}

abstract class AccountException implements Exception {
  final int accountId;
  AccountException(this.accountId);
}

class InsufficientFundsException extends AccountException {
  final int requestedAmount;

  InsufficientFundsException(this.requestedAmount, super.accountId);

  @override
  String toString() {
    return "Account ${super.accountId} doesn't have requested amount of $requestedAmount";
  }
}

class AccountNotFoundInOurBank extends AccountException {
  AccountNotFoundInOurBank(super.requestedAccount);

  @override
  String toString() {
    return "Account ${super.accountId} not registered in our bank at all";
  }
}

abstract class Command {
  final Bank bank;

  Command(this.bank);
  call();
}

class AddMoney extends Command {
  final int amount;
  final int accountId;
  AddMoney(super.bank, this.amount, this.accountId);

  @override
  call() {
    super.bank._addMoney(accountId, amount);
  }
}

class PrintAccountData extends Command {
  final int accountId;
  PrintAccountData(super.bank, this.accountId);

  @override
  call() {
    super.bank._printAccountInfo(accountId);
  }
}

class WithdrawMoney extends Command {
  final int amount;
  final int accountId;
  WithdrawMoney(super.bank, this.amount, this.accountId);

  @override
  call() {
    super.bank._withdrawMoney(accountId, amount);
  }
}

class TransferMoney extends Command {
  final int amount;
  final int accountFrom;
  final int accountTo;
  TransferMoney(super.bank, this.amount, this.accountFrom, this.accountTo);

  @override
  call() {
    super.bank._transferMoney(accountFrom, accountTo, amount);
  }
}
