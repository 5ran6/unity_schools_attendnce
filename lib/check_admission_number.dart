import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_schools_attendnce/sign_up.dart';

class Check_admission_number extends StatefulWidget {
  @override
  _Check_admission_numberState createState() => _Check_admission_numberState();
}

class _Check_admission_numberState extends State<Check_admission_number> {
  bool _isLoading = false;
  var error = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    TextEditingController regNoController = new TextEditingController();

    check(String code) async {
      Map data = {'code': code.trim()};

      var jsonData;
      var response = await http
          .post("https://gamint-bimiis.com.ng/api/codeCheck", body: data);
          await SharedPreferences.getInstance();

      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonData = json.decode(response.body);
        print('success: ' + response.body);
        setState(() {
          _isLoading = false;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => sign_up(
                        regNo: regNoController.text.trim().toUpperCase(),
                      )),
              (Route<dynamic> route) => false);
        });
      } else {
        jsonData = json.decode(response.body);
        print('failed: ' + response.body);
        if (jsonData['status_code'] == 422) {
          //user not found prompt
          setState(() {
            if (jsonData['errors']['user'].toString() == 'null') {
              error = jsonData['errors']['code'].toString().substring(
                  1, jsonData['errors']['code'].toString().length - 1);
            } else {
              error = jsonData['errors']['user'].toString().substring(
                  1, jsonData['errors']['user'].toString().length - 1);
            }
            _isLoading = false;

            showToast('$error',
                context: context,
                animation: StyledToastAnimation.slideFromTop,
                reverseAnimation: StyledToastAnimation.slideToTop,
                position: StyledToastPosition.top,
                startOffset: Offset(0.0, -3.0),
                reverseEndOffset: Offset(0.0, -3.0),
                duration: Duration(seconds: 4),
                //Animation duration   animDuration * 2 <= duration
                animDuration: Duration(seconds: 1),
                curve: Curves.elasticOut,
                reverseCurve: Curves.fastOutSlowIn);
          });
        } else {
          //Something went wrong prompt
          setState(() {
            error = 'Oops! Something went wrong.';
            _isLoading = false;
            showToast('$error',
                context: context,
                animation: StyledToastAnimation.slideFromTop,
                reverseAnimation: StyledToastAnimation.slideToTop,
                position: StyledToastPosition.top,
                startOffset: Offset(0.0, -3.0),
                reverseEndOffset: Offset(0.0, -3.0),
                duration: Duration(seconds: 4),
                //Animation duration   animDuration * 2 <= duration
                animDuration: Duration(seconds: 1),
                curve: Curves.elasticOut,
                reverseCurve: Curves.fastOutSlowIn);
          });
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue[300],
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // width: double.infinity,
                    height: 150,
                    color: Colors.lightBlue[300],
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image(
                          image: AssetImage('assets/logo_round.png'),
                          width: 100,
                          height: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    //height: MediaQuery.of(context).size.height - 150.0,
                    color: Colors.lightBlue[300],
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.white)),
                      margin: EdgeInsets.fromLTRB(25, 25, 25, 25),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Access Code",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 5,
                                  fontWeight: FontWeight.bold),
                            ),
                            const ListTile(
//leading: AssetImage(),
                              title: Text('Verification'),
                              subtitle: Text(
                                  'Every child is linked to an access code. Input the access code for any of your children then click "CHECK" to proceed. '),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                controller: regNoController,
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    labelText: 'Input Code',
                                    labelStyle:
                                        TextStyle(color: Colors.black54),
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(28.0),
                                    side: BorderSide(color: Colors.green[300])),
                                color: Colors.blue[700],
                                minWidth: 300,
                                height: 50,
                                onPressed: () {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  check(regNoController.text
                                      .trim()
                                      .toUpperCase());
                                },
                                child: Text(
                                  "C H E C K",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
    ;
  }
}
