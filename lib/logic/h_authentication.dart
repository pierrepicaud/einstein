import 'package:einstein/data/modules/account.dart';
import '../data/repos/i_account.dart';

class HAuthentication {
  final IAccount db;

  const HAuthentication(this.db);

  Future<String?> signIn(String login, String password) async {
    final userCred = await db.signInWithPassword(login, password);
    return userCred != null ? null : "User not found";
  }

  Future<String?> signUp(
      String login, String password, Map<String, String> additanalData) async {
    if (!additanalData.containsKey('username') ||
        additanalData['username']!.isEmpty) return "Username was not provided";
    final userCred = await db.signUpWithPassword(login, password);
    if (userCred == null) return "Cannot create such user";
    final acc = Account(userName: additanalData['username']!);
    db.addAccount(userCred.user!.uid, acc);
    return null;
  }
}
