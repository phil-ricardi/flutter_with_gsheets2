import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// Utils
import 'Utils/utils.dart';
// Auth
import 'auth/auth_page.dart';
import 'auth/verify_email_page.dart';
// Pages
import 'pages/contract_job_page.dart';
import 'pages/invoice_page.dart';
import 'pages/settings_page.dart';
import 'theme/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String title = 'I hope this worx';

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
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        title: MyApp.title,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: Utils.messengerKey,
        debugShowCheckedModeBanner: false,
        theme: isDarkMode ? darkTheme : lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const MainPage(),
          '/settings': (context) => const SettingsPage(),
          '/invoice': (context) => const InvoicePage(),
          '/contract': (context) => const ContractJobForm(),
        },
      ),
    );
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
