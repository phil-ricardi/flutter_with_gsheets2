import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import '../Utils/icon_widget.dart';
import '../Utils/utils.dart';
import 'account_page.dart';
import 'notifications_page.dart';

class SettingsPage extends StatelessWidget {
  static const keyDarkMode = 'key-dark-mode';

  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('widget.title'),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              SettingsGroup(
                title: '',
                children: <Widget>[buildDarkMode()],
              ),
              SettingsGroup(
                title: 'General',
                children: <Widget>[
                  const AccountPage(),
                  const NotificationsPage(),
                  buildLogout(),
                  buildDeleteAccount(),
                ],
              ),
              const SizedBox(height: 32),
              SettingsGroup(
                title: 'FEEDBACK',
                children: <Widget>[
                  const SizedBox(height: 8),
                  buildReportBug(context),
                  buildSendFeedback(context),
                ],
              )
            ],
          ),
        ),
      );

  Widget buildDarkMode() => SwitchSettingsTile(
        title: 'Dark Mode',
        settingKey: keyDarkMode,
        leading: const IconWidget(
          icon: Icons.dark_mode,
          color: Color(0xFF642ef3),
        ),
        onChange: (_) {},
      );

  Widget buildLogout() => SimpleSettingsTile(
        title: 'Logout',
        subtitle: '',
        leading: const IconWidget(icon: Icons.logout, color: Colors.blueAccent),
        onTap: () => Utils.showSnackBar('Clicked Logout'),
      );

  Widget buildDeleteAccount() => SimpleSettingsTile(
        title: 'Delete Account',
        subtitle: '',
        leading: const IconWidget(icon: Icons.delete, color: Colors.pink),
        onTap: () => Utils.showSnackBar('Clicked Delete'),
      );

  Widget buildReportBug(BuildContext context) => SimpleSettingsTile(
        title: 'Report A Bug',
        subtitle: '',
        leading: const IconWidget(icon: Icons.bug_report, color: Colors.teal),
        onTap: () => Utils.showSnackBar('Clicked Report A Bug'),
      );

  Widget buildSendFeedback(BuildContext context) => SimpleSettingsTile(
        title: 'Send Feedback',
        subtitle: '',
        leading: const IconWidget(icon: Icons.thumb_up, color: Colors.purple),
        onTap: () => Utils.showSnackBar('Clicked Send Feedback'),
      );
}
