import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_gsheets2/pages/auth_page.dart';
import 'package:flutter_with_gsheets2/pages/verify_email_page.dart';
import 'package:flutter_with_gsheets2/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'I hope this worx';

  const MyApp({Key? key}) : super(key: key);

  get navigatorKey => null;

  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: Utils.messengerKey,
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSwatch(primaryColorDark: Colors.black12)
              .copyWith(secondary: Colors.tealAccent),
        ),
        home: const MainPage(),
      );
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
