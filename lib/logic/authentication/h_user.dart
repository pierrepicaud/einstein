import 'package:einstein/data/authentication/modules/account.dart';
import 'package:einstein/data/authentication/repos/account_database.dart';

class HUser{
  
  final _db = AccountData();


  Account? _user;
  Account get cUser => _user ?? _fetchCurrentUser();
  String get userID => _db.user!.uid;

  Account _fetchCurrentUser(){
    _user = getUserByID(userID);
    return _user!;
  }

  Account getUserByID(String userID){
    //TODO: implement this function
    return Account(userName: 'pepega');
  }

  String getAvatarUrl(String? pictureID){
    // TODO: fetch aavatar from db
    return 'https://www.classmag.ru/tilda.sites/classmag/classmag-img/tild6265-3863-4963-b761-653137363930__usersilhouette_.jpg';
  }
}