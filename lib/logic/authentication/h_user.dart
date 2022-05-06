import 'package:einstein/data/authentication/modules/account.dart';
import 'package:einstein/data/authentication/repos/account_database.dart';
import 'package:einstein/data/main_screen/repos/picture_database.dart';

class HUser{
  
  final _db = AccountData();
  final _picDB = PictureData();

  Account? _user;
  Future<Account> get cUser => _user == null ? _fetchCurrentUser() : Future.value(_user) ;
  String get userID => _db.user!.uid;

  Future<Account> _fetchCurrentUser() async {
    _user = await getUserByID(userID);
    return _user!;
  }

  Future<Account> getUserByID(String userID) async{
    //TODO: implement this function
    return Account(userName: 'pepega');
  }

  String getAvatarUrl(String? pictureID){
    if(pictureID == null) return _picDB.baseAvatarUrl;
    return 'https://www.classmag.ru/tilda.sites/classmag/classmag-img/tild6265-3863-4963-b761-653137363930__usersilhouette_.jpg';
  }
}