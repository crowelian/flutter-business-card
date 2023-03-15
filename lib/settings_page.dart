import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_card/preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'color_provider.dart';
import 'main_colors.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: colorProvider.backgroundColor,
      ),
      backgroundColor: colorProvider.backgroundColor,
      body: Column(children: [
        Expanded(
          child: GridView.count(crossAxisCount: 3, children: [
            ColorTile(Color.fromRGBO(255, 106, 0, 1)),
            ColorTile(Color.fromRGBO(0, 0, 0, 1)),
            ColorTile(Colors.teal),
            ColorTile(Color.fromRGBO(153, 31, 61, 1)),
            ColorTile(Color.fromRGBO(82, 64, 171, 1)),
            ColorTile(Color.fromARGB(255, 112, 188, 232)),
          ]),
        ),
        Container(
          margin: EdgeInsets.all(15),
          child: ElevatedButton(
              onPressed: () => {
                    saveBackgroundColor(colorProvider.backgroundColor),
                    Fluttertoast.showToast(
                        msg: 'Background Color saved to preferences!',
                        backgroundColor: colorProvider.backgroundColor,
                        textColor: MainColors.textColor),
                    Navigator.pop(context)
                  },
              child: Text("save settings"),
              style: ElevatedButton.styleFrom(
                  primary: colorProvider.backgroundColor)),
        )
      ]),
    );
  }
}

class ColorTile extends StatelessWidget {
  final Color color;
  ColorTile(this.color);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ColorProvider>(context, listen: false)
            .changeBackgroundColor(color);
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color, border: Border.all(color: Colors.white, width: 1)),
      ),
    );
  }
}
