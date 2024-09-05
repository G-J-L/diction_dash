import 'package:diction_dash/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Toggle variables
  bool _notifications = true;
  bool _autoCapsLock = true;
  bool _sounds = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: kOswaldMedium,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text('Preferences'),
            onTap: () {},
          ),
          SwitchListTile(
            secondary: Icon(Icons.notifications),
            title: Text('Notifications'),
            value: _notifications,
            onChanged: (bool value) {
              setState(() {
                _notifications = value;
              });
            },
            activeTrackColor: kOrangeColor300,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.shade400,
          ),
          SwitchListTile(
            secondary: Icon(Icons.arrow_upward),
            title: Text('Auto caps-lock'),
            value: _autoCapsLock,
            onChanged: (bool value) {
              setState(() {
                _autoCapsLock = value;
              });
            },
            activeTrackColor: kOrangeColor300,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.shade400,
          ),
          SwitchListTile(
            secondary: Icon(Icons.volume_up),
            title: Text('Sounds'),
            value: _sounds,
            onChanged: (bool value) {
              setState(() {
                _sounds = value;
              });
            },
            activeTrackColor: kOrangeColor300,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.shade400,
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('FAQ & About'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Help & Support'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
