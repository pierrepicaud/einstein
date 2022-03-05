class Account{
  final String login;
  final String passhash;

  const Account(
    {
      required this.login,
      required this.passhash,
    }
  );

  @override
  String toString() {
    return 'Account(login: $login, passhash: $passhash)';
  }
}