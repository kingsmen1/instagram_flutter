import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/resonsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/resonsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/resonsive/web_screen_layout.dart';
import 'package:instagram_flutter/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout()));
  }
}
