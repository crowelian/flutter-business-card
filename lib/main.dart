import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:fluttertoast/fluttertoast.dart'
    if (kIsWeb) 'package:fluttertoast/fluttertoast_web.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'main_colors.dart';

void main() {
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
    backgroundColor: MainColors.boxColor,
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
          msg: 'Error calling!',
          backgroundColor: MainColors.red,
          textColor: MainColors.textColor);
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
          backgroundColor: MainColors.red,
          textColor: MainColors.textColor);
    }
    Clipboard.setData(ClipboardData(text: email));
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri(scheme: 'https', host: url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      Fluttertoast.showToast(
          msg: 'Could not launch the url',
          backgroundColor: MainColors.red,
          textColor: MainColors.textColor);
      throw "Could not launch the url";
    }
  }

  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: MainColors.orange,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onDoubleTap: () => {
                      Fluttertoast.showToast(
                          msg: 'Yes, it is me... $username',
                          backgroundColor: MainColors.mainColor,
                          textColor: MainColors.textColor)
                    },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: MainColors.debugColor,
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
                  color: MainColors.lightGray,
                  fontSize: 20,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
              width: 150,
              child: Divider(color: MainColors.orangeLight),
            ),
            GestureDetector(
                onTap: () {
                  _makePhoneCall(info1);
                },
                child: Card(
                    color: MainColors.boxColor,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: ListTile(
                      leading: Icon(Icons.phone, color: MainColors.orange),
                      title: Text(info1,
                          style: TextStyle(
                            color: MainColors.mainColorShade900,
                            fontFamily: 'Soce Sans Pro',
                            fontSize: 20,
                          )),
                    ))),
            GestureDetector(
                onTap: () {
                  _sendMail(info2);
                },
                child: Card(
                    color: MainColors.boxColor,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: ListTile(
                      leading: Icon(Icons.email, color: MainColors.orange),
                      title: Text(info2,
                          style: TextStyle(
                            color: MainColors.mainColorShade900,
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
