import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../view/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color btnColor = const Color(0xFF9575CD);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    welcome(context);
  }

  Future<void> welcome(BuildContext context) async {
    Timer(const Duration(seconds: 2), () async {   // This will show the splash screen for 2 seconds then HomeScreen will open
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  btnColor.withOpacity(0.2),
                  btnColor.withOpacity(0.4),
                  btnColor.withOpacity(0.6),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 55,
                    child: ClipOval(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('images/news_app.png', fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18.0),
                    child: Text("Buzz Bulletin",
                        style: TextStyle(
                          color: Color(0xFF311B92),
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
