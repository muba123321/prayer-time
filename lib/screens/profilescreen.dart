import 'package:flutter/material.dart';
import 'package:gicc/providers/auth_provider.dart';
import 'package:gicc/widgets/auth_widgets/logindialog.dart';
import 'package:gicc/widgets/auth_widgets/registrationdialog.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final String address = '123 Islamic Center St, City, Country';
  final String phoneNumber = '+1234567890';
  final String email = 'info@islamiccenter.com';

  void _launchURL(String url) async {
    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Login As Admin',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 16, right: 16, bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LoginDialog();
                  },
                );
              },
              child: const Text('Login'),
            ),
          ),
          if (notifier.user != null) ...[
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 16, right: 16, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Create User
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const RegisterDialog();
                    },
                  );
                },
                child: const Text('Create A New Admin User'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 16, right: 16, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Register User Screen
                  notifier.signOut();
                },
                child: const Text('SignOut'),
              ),
            ),
          ],
          SwitchListTile(
            title: const Text('Prayer Time Notifications'),
            value: true,
            onChanged: (bool value) {
              // Handle notification toggle
            },
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Contact Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            visualDensity: VisualDensity.compact,
            contentPadding: const EdgeInsets.only(left: 16),
            leading: const Icon(Icons.location_on),
            minLeadingWidth: 0,
            title: Text(address),
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            contentPadding: const EdgeInsets.only(left: 16),
            leading: const Icon(Icons.phone),
            minLeadingWidth: 0,
            title: Text(phoneNumber),
            onTap: () => _launchURL('tel:$phoneNumber'),
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.only(left: 16),
            leading: const Icon(Icons.email),
            title: Text(email),
            onTap: () => _launchURL('mailto:$email'),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Follow Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 86,
                width: 86,
                child: IconButton(
                  icon: Image.asset('assets/images/facebook.png'),
                  onPressed: () => _launchURL(
                      'https://www.facebook.com/profile.php?id=100080973976556'),
                ),
              ),
              SizedBox(
                height: 86,
                width: 86,
                child: IconButton(
                  icon: Image.asset('assets/images/insta.png'),
                  onPressed: () => _launchURL('https://www.instagram.com'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
