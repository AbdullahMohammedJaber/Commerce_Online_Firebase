import 'package:flutter/material.dart';
import 'package:kdr_store/consts/colors.dart';
import 'package:kdr_store/screens/landing_page.dart';
import 'package:kdr_store/screens/user_state.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) {
            return UserState();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: AssetImage('assets/images/icon.jpeg'),
                width: 150,
                height: 150,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .3,
          ),
          CircularProgressIndicator(
            color: ColorsConsts.gradiendFEnd,
          )
        ],
      ),
    );
  }
}
