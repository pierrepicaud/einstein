import 'dart:io';

import 'package:einstein/data/authentication/modules/account.dart';
import 'package:hive/hive.dart';

class AccountLocalStorage {
  Account? _acccount;
  final _boxName = 'AccountBox';
  final _loginKey = 'login';
  final _passHashKey = 'passhash';

  Account get account => _acccount ?? _loadAcc();

  Account _loadAcc() {
    var box = Hive.box(_boxName);
    if (box.isEmpty){
      throw Exception('There is no account data stored in memory');
    }
    _acccount =
        Account(login: box.get(_loginKey), passhash: box.get(_passHashKey));
    box.close();
    return _acccount!;
  }

  void saveAccount(Account account) {
    var box = Hive.box(_boxName);
    box.put(_loginKey, account.login);
    box.put(_passHashKey, account.passhash);
    box.close();
    _acccount = account;
  }
  
  void removeAccount(){
    var box = Hive.box(_boxName);
    box.clear();
    box.close();
  }
}
