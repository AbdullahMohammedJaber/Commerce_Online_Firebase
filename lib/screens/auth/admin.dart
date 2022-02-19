// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kdr_store/consts/colors.dart';
import 'package:kdr_store/screens/upload_product_form.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Admin extends StatefulWidget {
  static const routeName = '/Admin';
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  var user = 'admin';
  var pass = 'admin';

  var _userName = TextEditingController();

  var _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [ColorsConsts.gradiendFStart, ColorsConsts.gradiendLStart],
                    [ColorsConsts.gradiendFEnd, ColorsConsts.gradiendLEnd],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    //  color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.flaticon.com/icons/png/128/869/869636.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: _userName,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            labelText: 'Username',
                            fillColor: Theme.of(context).backgroundColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: _password,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                            fillColor: Theme.of(context).backgroundColor),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(width: 10),
                        ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(
                                    color: ColorsConsts.backgroundColor),
                              ),
                            )),
                            onPressed: () {
                              String x = _userName.text;
                              String y = _password.text;
                              if (x == user && y == pass) {
                                Navigator.of(context)
                                    .pushNamed(UploadProductForm.routeName);
                                print("done");
                              } else {
                                print("not");
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Feather.user,
                                  size: 18,
                                )
                              ],
                            )),
                        SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
