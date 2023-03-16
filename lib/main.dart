import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_card/json_data_provider.dart';
import 'package:flutter_business_card/settings_page.dart';
import 'package:flutter_business_card/user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:fluttertoast/fluttertoast.dart'
    if (kIsWeb) 'package:fluttertoast/fluttertoast_web.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'config.dart';
import 'main_colors.dart';
import 'package:provider/provider.dart';
import 'color_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ColorProvider(),
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);

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

    QrImage _generateQrCode(String personalLink) {
      return QrImage(
        data: personalLink,
        version: QrVersions.auto,
        size: 100,
        gapless: false,
        backgroundColor: MainColors.boxColor,
      );
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

    Future<User> _loadUserData() async {
      try {
        if (Config.useJwtAuthorization) {
          return await JsonDataProvider().fetchUserDataWithJwt(Config.userId);
        } else {
          return await JsonDataProvider().fetchUserDataFromUrl();
        }
      } catch (error) {
        print(error);
        return await JsonDataProvider().fetchUserDataFromAssets();
      }
    }

    return Scaffold(
      backgroundColor: colorProvider.backgroundColor,
      body: Consumer<ColorProvider>(
        builder: (context, colorProvider, child) => SafeArea(
          child: FutureBuilder<User>(
            future: _loadUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error loading user data!"));
              } else {
                final userData = snapshot.data!;

                return (Column(children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onDoubleTap: () => {
                          Fluttertoast.showToast(
                              msg: 'Yes, it is me... ${userData.username}',
                              backgroundColor: MainColors.mainColor,
                              textColor: MainColors.textColor)
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: MainColors.debugColor,
                          backgroundImage:
                              AssetImage('assets/images/portrait.png'),
                        ),
                      ),
                      Text(
                        userData.username,
                        style: TextStyle(
                            fontFamily: 'Shadows Into Light',
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      ),
                      Text(
                        userData.userTitle,
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
                          _makePhoneCall(userData.info1);
                        },
                        child: Card(
                          color: MainColors.boxColor,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: ListTile(
                            leading:
                                Icon(Icons.phone, color: MainColors.orange),
                            title: Text(
                              userData.info1,
                              style: TextStyle(
                                color: MainColors.mainColorShade900,
                                fontFamily: 'Soce Sans Pro',
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _sendMail(userData.info2);
                        },
                        child: Card(
                          color: MainColors.boxColor,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: ListTile(
                            leading:
                                Icon(Icons.email, color: MainColors.orange),
                            title: Text(
                              userData.info2,
                              style: TextStyle(
                                color: MainColors.mainColorShade900,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                          onTap: () => {_launchUrl(userData.userUrl)},
                          child: _generateQrCode(userData.personalInfoQrLink)),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  )),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(15),
                    child: FloatingActionButton(
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()))
                      },
                      child: Icon(Icons.settings, color: MainColors.textColor),
                      backgroundColor: colorProvider.backgroundColor,
                    ),
                  )
                ]));
              }
            },
          ),
        ),
      ),
    );
  }
}
