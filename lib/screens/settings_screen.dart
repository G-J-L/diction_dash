import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/screens/profile_screen.dart';

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SettingCard(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
          ),
          SettingCard(
            child: ListTile(
              leading: Icon(Icons.image),
              title: Text('Preferences'),
              onTap: () {},
            ),
          ),
          SettingCard(
            child: SwitchListTile(
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
          ),
          SettingCard(
            child: SwitchListTile(
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
          ),
          SettingCard(
            child: SwitchListTile(
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
          ),
          SettingCard(
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text('FAQ & About'),
              onTap: () {},
            ),
          ),
          SettingCard(
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text('Help & Support'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  const SettingCard({this.child, this.onPressed});

  final Widget? child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: kGrayColor200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
      ),
    );
  }
}
