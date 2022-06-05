import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool sysTheme = false;
  bool darkTheme = false;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: SettingsList(
            sections: [
              SettingsSection(
                title: const Text('Section 1'),
                tiles: [
                  SettingsTile(
                    title: const Text('Language'),
                    description: const Text('English'),
                    leading: const Icon(Icons.language),
                    onPressed: (BuildContext context) {},
                  ),
                  SettingsTile.switchTile(
                    title: const Text('Use fingerprint'),
                    leading: const Icon(Icons.fingerprint),
                    initialValue: false,
                    onToggle: (bool value) {},
                  ),
                ],
              ),
              SettingsSection(
                title: const Text('Section 2 Theme'),
                tiles: [
                  SettingsTile.switchTile(
                    title: const Text('Use System Theme'),
                    leading: const Icon(Icons.phone_android),
                    initialValue: sysTheme,
                    onToggle: (value) {},
                  ),
                  SettingsTile.switchTile(
                    title: const Text('Dark Theme'),
                    leading: const Icon(Icons.lightbulb),
                    initialValue: darkTheme,
                    onToggle: (value) {
                      setState(
                        () {
                          if (value = false) {
                            darkTheme = false;
                          } else {
                            darkTheme = true;
                          }
                        },
                      );
                    },
                    onPressed: (darkTheme) {
                      setState(
                        () {},
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
