import 'package:einstein/logic/authentication/authentication_logic.dart';
import 'package:einstein/ui/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';

import '../../data/constants.dart';
import '../../logic/transitions/custom_route.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';
  final _authLogic = Authentication();

  LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data) {
    return _authLogic.signIn(data.name, data.password);
  }

  Future<String?> _signupUser(SignupData data) {
    if (data.name == null || data.password == null) {
      return Future.value("Provide email and password");
    }
    return _authLogic.signUp(data.name!, data.password!);
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: Constants.appName,
      // logo: AssetImage(),
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      navigateBackAfterRecovery: true,
      // onConfirmRecover: _signupConfirm,
      // onConfirmSignup: _signupConfirm, 
      loginAfterSignUp: true,
      loginProviders: [
        LoginProvider(
          button: Buttons.Twitter,
          label: 'Twitter',
          callback: () async {
            return null;
          },
          providerNeedsSignUpCallback: () {
            // put here your logic to conditionally show the additional fields
            return Future.value(true);
          },
        )
      ],
      termsOfService: [
        TermOfService(
            id: 'general-term',
            mandatory: true,
            text: 'Term of services',
            linkUrl: 'https://github.com/NearHuscarl/flutter_login'),
      ],
      // additionalSignupFields: 
      initialAuthMode: AuthMode.login,
      userValidator: (value) {
        if (!value!.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {
        debugPrint('Login info');
        debugPrint('Name: ${loginData.name}');
        debugPrint('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSignup: (signupData) {
        debugPrint('Signup info');
        debugPrint('Name: ${signupData.name}');
        debugPrint('Password: ${signupData.password}');

        signupData.additionalSignupData?.forEach((key, value) {
          debugPrint('$key: $value');
        });
        if (signupData.termsOfService.isNotEmpty) {
          debugPrint('Terms of service: ');
          for (var element in signupData.termsOfService) {
            debugPrint(
                ' - ${element.term.id}: ${element.accepted == true ? 'accepted' : 'rejected'}');
          }
        }
        return _signupUser(signupData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => const MainPage(),
        ));
      },
      onRecoverPassword: (name) {
        debugPrint('Recover password info');
        debugPrint('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
    );
  }
}
