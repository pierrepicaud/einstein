import 'package:einstein/logic/authentication/authentication_logic.dart';
import 'package:einstein/ui/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';

import '../../data/constants.dart';
import '../../logic/transitions/custom_route.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    // final ImageProvider _imageProvider;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    //Gradiente

                    Container(
                      // margin: const EdgeInsets.all(10),
                      // padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      // height: 1024,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade400,
                            Colors.blue,
                            Colors.blueAccent.shade400,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 520),
                      child: Text(
                        'einstein',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      /*Image.asset(
                        'assets/images/tinder_logo.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        color: Colors.white,
                        scale: 1.3,
                      )*/
                    ),

                    Container(
                      //padding: const EdgeInsets.all(20.0),
                      width: 500.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(201, 236, 245, 0.922),
                          border: Border.all(
                            color: const Color.fromARGB(255, 5, 4, 82),
                          ),
                          borderRadius: BorderRadius.circular(
                              20) // use instead of BorderRadius.all(Radius.circular(20))
                          ),
                      margin: const EdgeInsets.all(30.0),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'By clicking Log in, you agree with our Terms. Learn how we process your data in our Privacy Policy and Cookies Policy.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SignInButton(
                            Buttons.Twitter,
                            onPressed: () {},
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Trouble logging in?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*class LoginScreen extends StatelessWidget {
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
      // onConfirmRecover: _signupConfirm, -- email address aprovement
      // onConfirmSignup: _signupConfirm, -- email address aprovement
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
}*/
