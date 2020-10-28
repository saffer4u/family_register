import 'dart:convert' as convert;
import 'models/feedback_form.dart';
import 'package:http/http.dart' as http;

class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL
  static const String URL =
      "https://script.google.com/macros/s/AKfycbzZWseg90jfR04CfSO46IWFJDiFtaRrei50pw6B/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async {
    try {
      await http.get(URL + feedbackForm.toParams()).then((response) {
        callback(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      print(e);
    }
  }
}

// Sheet Download link : https://docs.google.com/spreadsheets/d/1ax-G_Y-qlJRioFbBAdwaDf10bv8ThaBNlyk3Bl72vEU/export?format=xlsx
