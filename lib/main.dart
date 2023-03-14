import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:fluttertoast/fluttertoast.dart'
    if (kIsWeb) 'package:fluttertoast/fluttertoast_web.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  Color mainColor = const Color.fromRGBO(0, 0, 0, 1);
  Color mainColorInertedOpacity100 = Color.fromRGBO(
      255 - mainColor.red, 255 - mainColor.green, 255 - mainColor.blue, 0.4);
  Color mainColorShade900 = mainColor.withOpacity(0.9);
  Color boxColor = Colors.white;
  Color red = Color.fromRGBO(227, 25, 55, 1);
  Color burgundy = Color.fromRGBO(153, 31, 61, 1);
  Color purple = Color.fromRGBO(82, 64, 171, 1);
  Color purpleDark = Color.fromRGBO(32, 10, 88, 1);

  Color lightGray = Color.fromRGBO(225, 225, 225, 1);
  Color orange = Color.fromRGBO(255, 106, 0, 1);
  Color orangeLight = Color.fromRGBO(255, 195, 153, 1);

  String username = 'NAME';
  String userTitle = 'USERTITLE';
  String info1 = 'INFO1';
  String info2 = 'INFO2';

  String userUrl = "google.com";
  String personalInfoQR = 'https//$userUrl';

  final qrCode = QrImage(
    data: personalInfoQR,
    version: QrVersions.auto,
    size: 100,
    gapless: false,
    backgroundColor: boxColor,
  );

  void _makePhoneCall(String phonenumber) async {
    String url = 'tel:$phonenumber';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (error) {
      Fluttertoast.showToast(
          msg: 'Error calling!', backgroundColor: red, textColor: Colors.white);
    }
  }

  void _sendMail(String email) async {
    String url = 'mailto:$email';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (error) {
      Fluttertoast.showToast(
          msg:
              'Error opening mail app. \nI\'ve copied the email to your clipboard.',
          backgroundColor: red,
          textColor: Colors.white);
    }
    Clipboard.setData(ClipboardData(text: email));
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri(scheme: 'https', host: url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      Fluttertoast.showToast(
          msg: 'Could not launch the url',
          backgroundColor: red,
          textColor: Colors.white);
      throw "Could not launch the url";
    }
  }

  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: orange,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onDoubleTap: () => {
                      Fluttertoast.showToast(
                          msg: 'Yes, it is me... $username',
                          backgroundColor: mainColor,
                          textColor: Colors.white)
                    },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(255, 247, 8, 215),
                  backgroundImage: AssetImage('assets/images/portrait.png'),
                )),
            Text(username,
                style: TextStyle(
                    fontFamily: 'Shadows Into Light',
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3)),
            Text(
              userTitle,
              style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  color: lightGray,
                  fontSize: 20,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
              width: 150,
              child: Divider(color: orangeLight),
            ),
            GestureDetector(
                onTap: () {
                  _makePhoneCall(info1);
                },
                child: Card(
                    color: boxColor,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: ListTile(
                      leading: Icon(Icons.phone, color: orange),
                      title: Text(info1,
                          style: TextStyle(
                            color: mainColorShade900,
                            fontFamily: 'Soce Sans Pro',
                            fontSize: 20,
                          )),
                    ))),
            GestureDetector(
                onTap: () {
                  _sendMail(info2);
                },
                child: Card(
                    color: boxColor,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: ListTile(
                      leading: Icon(Icons.email, color: orange),
                      title: Text(info2,
                          style: TextStyle(
                            color: mainColorShade900,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 20,
                          )),
                    ))),
            SizedBox(
              height: 25,
            ),
            GestureDetector(onTap: () => {_launchUrl(userUrl)}, child: qrCode),
          ],
        )),
      ),
    ),
  );
}
