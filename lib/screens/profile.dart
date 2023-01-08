import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../constatnts/curveclipper.dart';
import '../models/user_model.dart';
import '../sotrage/user_bio.dart';
import '../widgets/button_widget.dart';
import '../widgets/numbeers_widget.dart';
import '../widgets/profile_widget.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    late final user = UserPreferences.getUser();
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => SafeArea(
          child: Scaffold(
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    color: Color(0XFF980F5A),
                    height: 300,
                    child: ProfileWidget(
                      imagePath: user.imagePath,
                      onClicked: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage()),
                        );
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                buildName(user),
                const SizedBox(height: 24),
                Center(child: buildUpgradeButton()),
                const SizedBox(height: 24),
                NumbersWidget(),
                const SizedBox(height: 48),
                buildAbout(user),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Charge your wallet',
        onClicked: () {},
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Address',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.address,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 26),
            Text(
              'Phone number',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Text(
              user.phonenumber,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 26),
            Text(
              'About you',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
