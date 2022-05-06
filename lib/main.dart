import 'package:einstein/ui/connectivity/notify_connectivity.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:einstein/data/constants.dart';
import 'package:einstein/firebase_options.dart';
import 'package:einstein/ui/account/account.dart';
import 'package:einstein/ui/mainpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'ui/authentication/login_screen.dart';
import 'logic/transitions/transition_route_observer.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: kIsWeb ? null : Constants.appName,
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotifyConnectivity(child: AppUI());
  }
}

class AppUI extends MaterialApp {
  AppUI({Key? key})
      : super(
          key: key,
          title: 'Login Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.blue.shade300,
            // primaryColor: Colors.black,
            dividerColor: Colors.black,
            textSelectionTheme:
                const TextSelectionThemeData(cursorColor: Colors.orange),
            textTheme: TextTheme(
              headline3: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 45.0,
                color: Colors.orange,
              ),
              button: const TextStyle(
                // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
                fontFamily: 'OpenSans',
              ),
              caption: TextStyle(
                fontFamily: 'NotoSans',
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                color: Colors.deepPurple[300],
              ),
              headline1: const TextStyle(fontFamily: 'Quicksand'),
              headline2: const TextStyle(fontFamily: 'Quicksand'),
              headline4: const TextStyle(fontFamily: 'Quicksand'),
              headline5: const TextStyle(fontFamily: 'NotoSans'),
              headline6: const TextStyle(fontFamily: 'NotoSans'),
              subtitle1: const TextStyle(fontFamily: 'NotoSans'),
              bodyText1: const TextStyle(fontFamily: 'NotoSans'),
              bodyText2: const TextStyle(fontFamily: 'NotoSans'),
              subtitle2: const TextStyle(fontFamily: 'NotoSans'),
              overline: const TextStyle(fontFamily: 'NotoSans'),
            ),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                .copyWith(secondary: Colors.orange),
          ),
          navigatorObservers: [TransitionRouteObserver()],
          initialRoute: LoginScreen.routeName,
          routes: {
            LoginScreen.routeName: (context) => LoginScreen(),
            MainPage.routeName: (context) => const MainPage(),
            Account.routeName: (context) => const Account(),
          },
        );
}
