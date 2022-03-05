import 'dart:convert';

import 'package:einstein/data/authentication/modules/account.dart';
 import 'package:crypto/crypto.dart';
import 'package:einstein/data/authentication/repos/account_database.dart';
import 'package:einstein/data/authentication/repos/local_starage.dart';

class Authentication{

  final AccountDatabase db = AccountDatabase();
  final AccountLocalStorage localAccount = AccountLocalStorage();

  Account get account => localAccount.account;

  String _getPassHash(String password){
    var hash = sha256.convert(utf8.encode(password));
    return hash.toString();
  }

  Future<bool> signIn(String login, String password) async{
    final acc = Account(login: login, passhash: _getPassHash(password));
    final appruve = await db.getAccount(acc);
    if(appruve){
      localAccount.saveAccount(acc);
      return true;
    }
    return false;
  }

  Future<bool> signUp(String login, String password) async{
    final acc = Account(login: login, passhash: _getPassHash(password));
    final appruve = await db.addAccount(acc);
    if(appruve){
      localAccount.saveAccount(acc);
      return true;
    }
    return false;
  }

}