// ignore_for_file: prefer_const_constructors

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shayari_app/first.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    forpermission();
    forsplashscreen();
  }

  forpermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await [
        Permission.storage,
      ].request();
    }
  }

  forsplashscreen() {
    Future.delayed(Duration(milliseconds: 5000)).then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FirstPage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hindi Shayari",
            style: GoogleFonts.arvo(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ))),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .width * 0.78,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.78,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: AssetImage("assets/images/logo.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
