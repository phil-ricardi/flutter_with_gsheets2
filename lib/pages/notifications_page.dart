import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import '/Utils/icon_widget.dart';

class NotificationsPage extends StatelessWidget {
  static const keyNews = 'key-news';
  static const keyActivity = 'key-activities';
  static const keyNewsletter = 'key-newsletter';
  static const keyAppUpdates = 'key-appUpdates';

  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
        title: 'Notifications',
        subtitle: 'Newsletter, App Updates',
        leading: const IconWidget(
          icon: Icons.notifications,
          color: Colors.redAccent,
        ),
        child: SettingsScreen(
          title: 'Notifications',
          children: <Widget>[
            buildNews(),
            buildActivity(),
            buildNewsletter(),
            buildAppUpdates(),
          ],
        ),
      );

  Widget buildNews() => SwitchSettingsTile(
        title: 'News For You',
        settingKey: keyNews,
        leading:
            const IconWidget(icon: Icons.message, color: Colors.blueAccent),
      );
  Widget buildActivity() => SwitchSettingsTile(
        title: 'Account Activity',
        settingKey: keyActivity,
        leading: const IconWidget(icon: Icons.person, color: Colors.orange),
      );
  Widget buildNewsletter() => SwitchSettingsTile(
        title: 'News For You',
        settingKey: keyNewsletter,
        leading: const IconWidget(icon: Icons.text_snippet, color: Colors.pink),
      );
  Widget buildAppUpdates() => SwitchSettingsTile(
        title: 'App Updates',
        settingKey: keyAppUpdates,
        leading: const IconWidget(icon: Icons.alarm, color: Colors.greenAccent),
      );
}
