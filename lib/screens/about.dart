import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const routeName = 'About';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Version : 1.0",
              style: TextStyle(fontSize: 30, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              "-: Design Developed By :- ",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "Aftab Alam",
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
