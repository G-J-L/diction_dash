import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/screens/settings/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Toggle variables
  bool _notifications = true;
  bool _autoCapsLock = true;
  bool _sounds = true;

  Future<void> _loadSoundPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _sounds = prefs.getBool('soundsEnabled')!;
    });
  }

  Future<void> _setSoundPreferences(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('soundsEnabled', value);
  }

  @override
  void initState() {
    super.initState();
    _loadSoundPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: kOswaldMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
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
              leading: const Icon(Icons.image),
              title: const Text('Preferences'),
              onTap: () {},
            ),
          ),
          SettingCard(
            child: SwitchListTile(
              secondary: const Icon(Icons.notifications),
              title: const Text('Notifications'),
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
              secondary: const Icon(Icons.arrow_upward),
              title: const Text('Auto caps-lock'),
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
              secondary: const Icon(Icons.volume_up),
              title: const Text('Sounds'),
              value: _sounds,
              onChanged: (bool value) {
                setState(() {
                  _sounds = value;
                });
                _setSoundPreferences(_sounds);
              },
              activeTrackColor: kOrangeColor300,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.shade400,
            ),
          ),
          SettingCard(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text('FAQ & About'),
              onTap: () {},
            ),
          ),
          SettingCard(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Help & Support'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  const SettingCard({super.key, this.child, this.onPressed});

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
