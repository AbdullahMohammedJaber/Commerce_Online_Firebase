import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About1 extends StatelessWidget {
  static const routeName = '/About1';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            _buildInfo1(),
            _buildInfo2(),
            _buildInfo3(),
            _buildInfo4(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo1() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.redAccent,
                        child: Image.asset(
                          'assets/images/icon.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('KDR Store'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text("Version"),
                    subtitle: Text("1.0"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.cached),
                    title: Text("Changelog"),
                    subtitle: Text("will be modified"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.offline_pin),
                    title: Text("License"),
                    subtitle: Text("Licensed by Trade Center"),
                  ),
                ],
              )),
        ));
  }

  Widget _buildInfo2() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Author',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Qedar"),
                    subtitle: Text("Al_quds"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.file_download),
                    title: Text("Download From Cloud"),
                  ),
                ],
              )),
        ));
  }

  Widget _buildInfo3() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Company',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text("computer store"),
                    subtitle: Text("Computer parts and accessories specialist"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text("Al_quds"),
                  ),
                ],
              )),
        ));
  }

  Widget _buildInfo4() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: _launchinstaL,
                    child: CircleAvatar(
                      radius: 35,
                      child: Image.asset('assets/images/instaa.png'),
                    ),
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
              )),
        ));
  }

  _launchinstaL() async {
    const url =
        'https://www.instagram.com/invites/contact/?i=1ct2hq0nx121b&utm_content=mvvd7kn‌‏';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchface() async {
    const url =
        'https://www.instagram.com/invites/contact/?i=1ct2hq0nx121b&utm_content=mvvd7kn‌‏';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchwhats() async {
    const url = 'https://wa.me/message/3KGXHUCFZIWDL1‌‏';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
