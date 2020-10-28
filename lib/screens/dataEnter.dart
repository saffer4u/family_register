import 'package:family_register/constents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/feedback_form.dart';
import '../controller.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DataEnter extends StatefulWidget {
  static const routeName = "dataEnter";

  @override
  _DataEnterState createState() => _DataEnterState();
}

class _DataEnterState extends State<DataEnter> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController sn = TextEditingController();
  TextEditingController houseNum = TextEditingController();
  TextEditingController familyHeadName = TextEditingController();
  TextEditingController familyMemberName = TextEditingController();
  TextEditingController hfName = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController other = TextEditingController();
  String dob = "";
  String dod = "";
  String gender = "पुरुष";
  String religion = "हिन्दू";
  String srNr = "निरक्षर";

  void _submitForm() {
    FocusScope.of(context).requestFocus(FocusNode());
    FeedbackForm feedbackForm = FeedbackForm(
      sn: sn.text,
      houseNum: houseNum.text,
      familyHeadName: familyHeadName.text,
      familyMemberName: familyMemberName.text,
      hfName: hfName.text,
      profession: profession.text,
      gender: gender,
      religion: religion,
      srNr: srNr,
      other: other.text,
      dob: dob,
      dod: dod,
    );

    FormController formController = FormController((String response) async {
      print("Response: $response");
      if (response == FormController.STATUS_SUCCESS) {
        _showSnackbar("Form Submitted");
        await new Future.delayed(const Duration(seconds: 2));
        setState(() {
          _saving = false;
        });
        Navigator.pushReplacementNamed(context, "/");
      } else {
        _showSnackbar("Error Occurred!");
      }
    });

    _showSnackbar("Submitting Form");

    // Submit 'feedbackForm' and save it in Google Sheet

    formController.submitForm(feedbackForm);
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  String selectedRadio;
  String selectedRadioRL;
  String selectedRadioSrNr;

  @override
  void initState() {
    super.initState();
    selectedRadio = 'पुरुष';
    selectedRadioRL = 'हिन्दू';
    selectedRadioSrNr = 'साक्षर';
  }

  setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;
      gender = val;
    });
  }

  setSelectedRadioRL(String val) {
    setState(() {
      selectedRadioRL = val;
      religion = val;
    });
  }

  setSelectedRadioSrNr(String val) {
    setState(() {
      selectedRadioSrNr = val;
      srNr = val;
    });
  }

  DateTime _dob = DateTime.utc(2000);
  DateTime _dod = DateTime.utc(2015);

  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.pushReplacementNamed(context, "/"),
              child: Icon(Icons.arrow_back),
              backgroundColor: pcol,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            key: _scaffoldKey,
            appBar: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/");
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              title: Text("परिवार ब्योरा"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  autofocus: true,
                                  controller: sn,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "क्रम सं0",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: houseNum,
                                  decoration: InputDecoration(
                                    labelText: "मकान नम्बर",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: familyHeadName,
                            decoration: InputDecoration(
                              labelText: "परिवार के मुखिया का नाम",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: familyMemberName,
                            decoration: InputDecoration(
                              labelText: "परिवार के सदस्यों का नाम",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: hfName,
                            decoration: InputDecoration(
                              labelText: "पिता/पति का नाम",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: profession,
                            decoration: InputDecoration(
                              labelText: "व्यवसाय",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: other,
                            decoration: InputDecoration(
                              labelText: "अन्य",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // DOB
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'जन्म तिथि',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: pcol,
                                    onPressed: () {
                                      showModalBottomSheet(
                                          isDismissible: false,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(10)),
                                          ),
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            return FractionallySizedBox(
                                              heightFactor: 0.4,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(15),
                                                      child:
                                                          CupertinoDatePicker(
                                                        initialDateTime: _dob,
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .date,
                                                        maximumDate:
                                                            DateTime.now(),
                                                        minimumDate:
                                                            DateTime.utc(1920),
                                                        onDateTimeChanged:
                                                            (date) {
                                                          setState(() {
                                                            _dob = date;
                                                            dob = DateFormat(
                                                                    "dd/MM/yyyy")
                                                                .format(DateTime
                                                                    .parse(date
                                                                        .toString()));
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      RaisedButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        onPressed: () {
                                                          setState(() {
                                                            dob = "";
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("Erase"),
                                                      ),
                                                      RaisedButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        color: pcol,
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child: Text(
                                                          "Ok",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 14,
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                  Text(dob == null ? '' : dob.toString()),
                                ],
                              ),

                              // DOD
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'मृत्यु का दिनांक',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: pcol,
                                    onPressed: () {
                                      showModalBottomSheet(
                                          isDismissible: false,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(10)),
                                          ),
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            return FractionallySizedBox(
                                              heightFactor: 0.4,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(15),
                                                      child:
                                                          CupertinoDatePicker(
                                                        initialDateTime: _dod,
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .date,
                                                        maximumDate:
                                                            DateTime.now(),
                                                        minimumDate:
                                                            DateTime.utc(1920),
                                                        onDateTimeChanged:
                                                            (date) {
                                                          setState(() {
                                                            _dod = date;
                                                            dod = DateFormat(
                                                                    "dd/MM/yyyy")
                                                                .format(DateTime
                                                                    .parse(date
                                                                        .toString()));
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      RaisedButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        onPressed: () {
                                                          setState(() {
                                                            dod = "";
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("Erase"),
                                                      ),
                                                      RaisedButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        color: pcol,
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child: Text(
                                                          "Ok",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 14,
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                  Text(dod == null ? '' : dod.toString()),
                                ],
                              ),
                            ],
                          ),

                          // Radio buttons :
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'पुरुष',
                                groupValue: selectedRadio,
                                activeColor: pcol,
                                onChanged: (val) {
                                  // print(val);
                                  setSelectedRadio(val);
                                },
                              ),
                              Text("पुरुष"),
                              Radio(
                                value: 'महिला',
                                groupValue: selectedRadio,
                                activeColor: pcol,
                                onChanged: (val) {
                                  // print(val);
                                  setSelectedRadio(val);
                                },
                              ),
                              Text("महिला"),
                            ],
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'हिन्दू',
                                groupValue: selectedRadioRL,
                                activeColor: pcol,
                                onChanged: (val) {
                                  // print(val);
                                  // setSelectedRadio(val);
                                  setSelectedRadioRL(val);
                                },
                              ),
                              Text("हिन्दू"),
                              Radio(
                                value: 'मुस्लिम',
                                groupValue: selectedRadioRL,
                                activeColor: pcol,
                                onChanged: (val) {
                                  // print(val);
                                  // setSelectedRadio(val);
                                  setSelectedRadioRL(val);
                                },
                              ),
                              Text("मुस्लिम"),
                            ],
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'निरक्षर',
                                groupValue: selectedRadioSrNr,
                                activeColor: pcol,
                                onChanged: (val) {
                                  // print(val);
                                  // setSelectedRadio(val);
                                  setSelectedRadioSrNr(val);
                                },
                              ),
                              Text("निरक्षर"),
                              Radio(
                                value: 'साक्षर',
                                groupValue: selectedRadioSrNr,
                                activeColor: pcol,
                                onChanged: (val) {
                                  // print(val);
                                  // setSelectedRadio(val);
                                  setSelectedRadioSrNr(val);
                                },
                              ),
                              Text("साक्षर"),
                            ],
                          ),
                          RaisedButton(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            color: pcol,
                            textColor: Colors.white,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Text(
                                    "Alert!",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: Text(
                                      "Are you sure you want to submit the form ?"),
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          _saving = true;

                                        });
                                        Navigator.pop(context);
                                        _submitForm();
                                      },
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(color: pcol),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: pcol),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }, //_submitForm
                            child: Text(
                              'Submit',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
