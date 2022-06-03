import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resourses/auth_methods.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/dimensions.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';
//import 'package:Cached';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, Constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: Constraints.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  width: double.infinity,
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(),
                          flex: 2,
                        ),
                        SvgPicture.asset(
                          "assets/ic_instagram.svg",
                          color: primaryColor,
                          height: 64,
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : const CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(
                                        'https://180dc.org/wp-content/uploads/2016/08/default-profile.png'),
                                    // child: CachedNetworkImage(
                                    //     imageUrl:
                                    //         'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                                  ),
                            Positioned(
                                bottom: 0,
                                left: 80,
                                child: IconButton(
                                  icon: Icon(Icons.add_a_photo),
                                  onPressed: selectImage,
                                ))
                          ],
                        ),
                        sizedBox24H,
                        TextFieldInput(
                          textEditingController: _userNameController,
                          textInputType: TextInputType.text,
                          hintext: 'Enter your Username',
                        ),
                        sizedBox24H,
                        TextFieldInput(
                          textEditingController: _emailController,
                          textInputType: TextInputType.emailAddress,
                          hintext: 'Enter your email',
                        ),
                        sizedBox24H,
                        TextFieldInput(
                          textEditingController: _passController,
                          textInputType: TextInputType.emailAddress,
                          hintext: 'Enter your password',
                        ),
                        sizedBox24H,
                        TextFieldInput(
                          textEditingController: _bioController,
                          textInputType: TextInputType.text,
                          hintext: 'Enter your bio',
                          isPass: false,
                        ),
                        sizedBox24H,
                        GestureDetector(
                          onTap: () async {
                            String res = await AuthMethods().signUpUser(
                                email: _emailController.text.trim(),
                                password: _passController.text.trim(),
                                username: _userNameController.text.trim(),
                                bio: _bioController.text.trim(),
                                file: _image!);
                            print(res);
                          },
                          child: Container(
                            child: const Text("Signup"),
                            width: double.infinity,
                            decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                color: blueColor),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Flexible(
                          child: Container(),
                          flex: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              child: Text("Don't you have an account?"),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
