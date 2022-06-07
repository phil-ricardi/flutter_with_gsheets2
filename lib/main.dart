import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'Utils/utils.dart';
// Pages
import 'auth/auth_page.dart';
import 'pages/invoice_page.dart';
import 'pages/settings_page.dart';
import 'auth/verify_email_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static const String title = 'I hope this worx';

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //final isDarkMode = Settings.getValue<bool>(SettingsPage.keyDarkMode, true);
    return ValueChangeObserver<bool>(
        cacheKey: SettingsPage.keyDarkMode,
        defaultValue: true,
        builder: (_, isDarkMode, __) => MaterialApp(
              title: MyApp.title,
              navigatorKey: navigatorKey,
              scaffoldMessengerKey: Utils.messengerKey,
              debugShowCheckedModeBanner: false,
              theme: isDarkMode
                  ? ThemeData.dark().copyWith(
                      primaryColor: Colors.teal,
                      secondaryHeaderColor: Colors.white,
                      scaffoldBackgroundColor: const Color(0xFF170635),
                      canvasColor: const Color.fromARGB(255, 18, 24, 105),
                      errorColor: const Color.fromARGB(255, 199, 3, 3),
                    )
                  : ThemeData.light().copyWith(
                      primaryColor: Colors.teal,
                      secondaryHeaderColor: Colors.black,
                      scaffoldBackgroundColor:
                          const Color.fromARGB(255, 21, 61, 190),
                      canvasColor: const Color.fromARGB(255, 108, 163, 226),
                      errorColor: const Color.fromARGB(255, 231, 19, 19),
                    ),
              initialRoute: '/',
              routes: {
                '/': (context) => const MainPage(),
                '/settings': (context) => const SettingsPage(),
                '/invoice': (context) => const InvoicePage(),
              },
            ));
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong!'));
            } else if (snapshot.hasData) {
              return const VerifyEmailPage();
            } else {}
            return const AuthPage();
          },
        ),
      );
}
