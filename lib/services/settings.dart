import 'package:flutter/material.dart';
import 'package:manpower_management_app/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    MyApp.isDarkMode = !MyApp.isDarkMode;
                  });
                },
                child: Text(MyApp.isDarkMode ? "Light Mode" : "Dark Mode"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
