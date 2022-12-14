import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';
import '../sotrage/user_bio.dart';
import '../widgets/appbar_widger.dart';
import '../widgets/button_widget.dart';
import '../widgets/profile_widget.dart';
import '../widgets/textfieeld_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();

    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {
                    // final image = await ImagePicker
                    //     .pickImage(source: ImageSource.gallery);
                    // .getImage(source: ImageSource.gallery);

                    // if (image == null) return print('image is null');
                    //
                    // final directory = await getApplicationDocumentsDirectory();
                    // final name = basename(image.path);
                    // final imageFile = File('${directory.path}/$name');
                    // final newImage =
                    //     await File(image.path).copy(imageFile.path);

                    //setState(() => user = user.copy(imagePath: newImage.path));
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name,
                  onChanged: (name) => user = user.copy(name: name),
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email) => user = user.copy(email: email),
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'About yourself',
                  text: user.about,
                  maxLines: 5,
                  onChanged: (about) => user = user.copy(about: about),
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Address',
                  text: user.address,
                  maxLines: 5,
                  onChanged: (address) => user = user.copy(address: address),
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Phone number',
                  text: user.phonenumber,
                  maxLines: 1,
                  onChanged: (phone) => user = user.copy(phonenumber: phone),
                ),
                const SizedBox(height: 24),
                ButtonWidget(
                  text: 'Save',
                  onClicked: () {
                    UserPreferences.setUser(user);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
