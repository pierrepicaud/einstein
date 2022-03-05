

import 'package:einstein/data/authentication/modules/account.dart';

class AccountDatabase{

  Future<bool> getAccount(Account account) async{
    // TODO: check whether this acc exist in database
    return true;
  }

  Future<bool> addAccount(Account account) async{
    // TODO: add account to database if we can
    return true;
  }

  void deleteAccount(Account account){
    // TODO: delete acc from database
  }

}