import 'package:family_register/constents.dart';
import 'package:family_register/screens/about.dart';
import 'package:family_register/screens/dataEnter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else
    throw 'Could Not Download';
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton<String>(onSelected: (op) {
              if (op == 'Download Or Edit') {
                _launchInBrowser(downloadUrl);
              } else if (op == 'About') {
                Navigator.pushNamed(context, AboutPage.routeName);
              }
              //   print('Edit Sheet');
              // }
            }, itemBuilder: (BuildContext context) {
              return {'Download Or Edit', 'About'}
                  .map((e) => PopupMenuItem<String>(
                        child: Text(e),
                        value: e,
                      ))
                  .toList();
            }),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          centerTitle: true,
          elevation: 10,
          title: Text(
            "परिवार रजिस्टर",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: WebView(
          initialUrl:
              "https://docs.google.com/spreadsheets/d/1ax-G_Y-qlJRioFbBAdwaDf10bv8ThaBNlyk3Bl72vEU/edit?usp=sharing",
          javascriptMode: JavascriptMode.unrestricted,
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: pcol,
          onPressed: () {
            Navigator.pushReplacementNamed(context, DataEnter.routeName);
          },
          label: Text("New Entry"),
          icon: Icon(
            Icons.navigate_next,
            size: 45,
          ),
        ),
      ),
    );
  }
}
