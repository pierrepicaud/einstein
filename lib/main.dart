import 'package:einstein/logic/authentication/h_user.dart';
import 'package:einstein/ui/connectivity/notify_connectivity.dart';
import 'package:einstein/ui/settings_page.dart';
import 'package:einstein/ui/theam.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:einstein/data/constants.dart';
import 'package:einstein/firebase_options.dart';
import 'package:einstein/ui/account/account.dart';
import 'package:einstein/ui/mainpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final userHendeler = HUser();
  
  MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final auth = userHendeler.auth;
    return NotifyConnectivity(
      child: ChangeNotifierProvider<ThemeProvider>(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeMode = Provider.of<ThemeProvider>(context).theme;
          return AppUI(
            themeMode: themeMode,
            initialRoute: (auth.currentUser == null)? LoginScreen.routeName: MainPage.routeName,
          );
        },
      ),
    );
  }
}

class AppUI extends MaterialApp {
  AppUI({
    Key? key,
    ThemeMode themeMode = ThemeMode.light,
    String? initialRoute,
  }) : super(
          key: key,
          title: 'Login Demo',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: AppThemes.lightTheam,
          darkTheme: AppThemes.darkTheam,
          navigatorObservers: [TransitionRouteObserver()],
          initialRoute: initialRoute,
          routes: {
            LoginScreen.routeName: (context) => LoginScreen(),
            MainPage.routeName: (context) => const MainPage(),
            AccountScreen.routeName: (context) => const AccountScreen(),
            SettingsPage.routeName: (context) => const SettingsPage(),
          },
        );
}
