import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/resonsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/resonsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/resonsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //kIsWeb is used for firebase to work on web.
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDEUOlYK9sd0RvRtbXQ4bthmCTbVwGrvSg",
            appId: "1:963225356080:web:dae697355ccf2a7a9deaf5",
            messagingSenderId: "963225356080",
            projectId: "instagram-clone-c13b8",
            storageBucket: "instagram-clone-c13b8.appspot.com"));
  }
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
      // home: ResponsiveLayout(
      //   webScreenLayout: WebScreenLayout(),
      //   mobileScreenLayout: MobileScreenLayout(),
      // ),
      home: LoginScreen(),
    );
  }
}
