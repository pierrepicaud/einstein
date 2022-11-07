import 'package:einstein/data/repos/constants.dart';
import 'package:einstein/data/repos/d_account.dart';
import 'package:einstein/data/repos/d_picture.dart';
import 'package:einstein/logic/h_user.dart';
import 'package:einstein/ui/screens/s_account.dart';
import 'package:einstein/ui/screens/s_login.dart';
import 'package:einstein/ui/screens/s_main.dart';
import 'package:einstein/ui/screens/s_settings.dart';
import 'package:einstein/ui/transitions/transition_route_observer.dart';
import 'package:einstein/ui/widgets/notify_connectivity.dart';
import 'package:einstein/ui/theme.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:einstein/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final userHendeler = HUser(DAccount(), DPicture());
  
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
            initialRoute: (auth.currentUser == null)? LoginScreen.routeName: MainScreen.routeName,
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
            MainScreen.routeName: (context) => const MainScreen(),
            AccountScreen.routeName: (context) => const AccountScreen(),
            SettingsScreen.routeName: (context) => const SettingsScreen(),
          },
        );
}
