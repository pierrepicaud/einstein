import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'ui/dashboard_screen.dart';
import 'ui/authentication/login_screen.dart';
import 'logic/transitions/transition_route_observer.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
            textDirection: TextDirection.ltr,
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return AppUI();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const CircularProgressIndicator();
      },
    );
  }
}

class AppUI extends MaterialApp {
  AppUI({Key? key})
      : super(
          key: key,
          title: 'Login Demo',
          theme: ThemeData(
            textSelectionTheme:
                const TextSelectionThemeData(cursorColor: Colors.orange),
            // fontFamily: 'SourceSansPro',
            textTheme: TextTheme(
              headline3: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 45.0,
                // fontWeight: FontWeight.w400,
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
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
                    .copyWith(secondary: Colors.orange),
          ),
          navigatorObservers: [TransitionRouteObserver()],
          initialRoute: LoginScreen.routeName,
          routes: {
            LoginScreen.routeName: (context) => LoginScreen(),
            DashboardScreen.routeName: (context) => const DashboardScreen(),
          },
        );
}
