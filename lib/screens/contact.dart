import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  static const routeName = '/Contact';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: _launchinstaL,
              child: CircleAvatar(
                radius: 35,
                child: Image.asset('assets/images/instaa.png'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: _launchface,
              child: CircleAvatar(
                radius: 35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/images/face.png'),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: _launchwhats,
              child: CircleAvatar(
                radius: 35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/images/whats.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchinstaL() async {
    const url = 'https://instagram.com/kdrstore2021?utm_medium=copy_link‌‏';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchface() async {
    const url = 'https://instagram.com/kdrstore2021?utm_medium=copy_link‌‏‌‏';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchwhats() async {
    const url = 'https://instagram.com/kdrstore2021?utm_medium=copy_link‌‏';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
