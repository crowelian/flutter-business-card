import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'color_provider.dart';

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
        body: GridView.count(crossAxisCount: 3, children: [
          ColorTile(Color.fromRGBO(255, 106, 0, 1)),
          ColorTile(Color.fromRGBO(0, 0, 0, 1)),
          ColorTile(Colors.teal),
          ColorTile(Color.fromRGBO(153, 31, 61, 1)),
          ColorTile(Color.fromRGBO(82, 64, 171, 1)),
          ColorTile(Color.fromARGB(255, 112, 188, 232)),
        ]));
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
