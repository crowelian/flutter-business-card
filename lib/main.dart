import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
            child: Column(
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundColor: Color.fromARGB(255, 247, 8, 215),
              backgroundImage: AssetImage('assets/images/portrait.png'),
            ),
          ],
        )),
      ),
    ),
  );
}
