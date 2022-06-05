import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_with_gsheets2/Utils/icon_widget.dart';

import '../Utils/utils.dart';

class AccountPage extends StatelessWidget {
  static const keyLanguage = 'key-language';
  static const keyLocation = 'key-location';
  static const keyPassword = 'key-password';
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
        title: 'Account Settings',
        subtitle: 'Privacy, Security, Language',
        leading: const IconWidget(icon: Icons.person, color: Colors.green),
        child: SettingsScreen(
          title: 'Account Settings',
          children: <Widget>[
            buildLanguage(),
            buildLocation(),
            buildPassword(),
            buildPrivacy(context),
            buildSecurity(context),
            buildAccountInfo(context),
            buildDefaultSettings(context),
          ],
        ),
      );

  Widget buildLanguage() => DropDownSettingsTile(
        title: 'Language',
        settingKey: keyLanguage,
        selected: 1,
        values: const <int, String>{
          1: 'English',
          2: 'Spanish',
          3: 'Chinese',
          4: 'Some other Shit',
        },
        onChange: (language) {},
      );
  Widget buildLocation() => TextInputSettingsTile(
        settingKey: keyLocation,
        title: 'Location',
        initialValue: 'America',
        onChange: (location) {},
      );
  Widget buildPassword() => TextInputSettingsTile(
        settingKey: keyPassword,
        title: 'Password',
        obscureText: true,
        validator: (password) => password != null && password.length >= 6
            ? null
            : 'Password must be at least 6 characters',
      );
  Widget buildPrivacy(BuildContext context) => SimpleSettingsTile(
        title: 'Privacy',
        subtitle: '',
        leading: const IconWidget(icon: Icons.lock, color: Colors.blue),
        onTap: () => Utils.showSnackBar('Clicked Privacy'),
      );

  Widget buildSecurity(BuildContext context) => SimpleSettingsTile(
        title: 'Security',
        subtitle: '',
        leading: const IconWidget(icon: Icons.security, color: Colors.red),
        onTap: () => Utils.showSnackBar('Clicked Security'),
      );

  Widget buildAccountInfo(BuildContext context) => SimpleSettingsTile(
        title: 'Account Info',
        subtitle: '',
        leading:
            const IconWidget(icon: Icons.text_snippet, color: Colors.purple),
        onTap: () => Utils.showSnackBar('Clicked Account Info'),
      );
  Widget buildDefaultSettings(BuildContext context) => SimpleSettingsTile(
        title: 'Revert Settings to Default',
        subtitle: '',
        leading: const IconWidget(
            icon: Icons.restore_page_outlined, color: Colors.red),
        onTap: () {
          Settings.clearCache();
          Utils.showSnackBar('Settings Will Be Reset');
        },
      );
}
