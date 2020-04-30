import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_schools_attendnce/dashboad_fab.dart';

class sign_in extends StatefulWidget {
  @override
  _sign_inState createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  bool _isLoading = false;
  var error = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue[800]));
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    signIn(String email, String password) async {
      Map data = {'email': email, 'password': password};

      var jsonData = null;
      var response =
          await http.post("https://gamint-bimiis.com.ng/api/login", body: data);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      if (response.statusCode == 201) {
        jsonData = json.decode(response.body);
        print('success: ' + response.body);
        setState(() {
          _isLoading = false;
          sharedPreferences.setString("token", jsonData['token']);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => FancyFab()),
              (Route<dynamic> route) => false);
        });
      } else {
        jsonData = json.decode(response.body);
        print('failed: ' + response.body);
        if (jsonData['status_code'] == 422) {
          //user not found prompt

          setState(() {
            error = 'User not found.';
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

    Padding login() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.white)),
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "SIGN IN",
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
                        title: Text('Franship 101'),
                        subtitle: Text(
                            'Welcome to Franship 101. Your mind controls your life. Sign in to access contents that will enrich your mind today'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Text(
                        "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 5,
                            fontWeight: FontWeight.bold),
                      ),
                      Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(28.0),
                              side: BorderSide(color: Colors.green[300])),
                          color: Colors.blue[700],
                          minWidth: double.infinity,
                          height: 50,
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            signIn(
                                emailController.text, passwordController.text);
                          },
                          child: Text(
                            "S I G N  I N",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Text(
                        "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 5,
                            fontWeight: FontWeight.bold),
                      ),
                      Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.green[300])),
                          color: Colors.white,
                          minWidth: double.infinity,
                          height: 30,
                          onPressed: () {},
                          child: Text(
                            "S I G N  U P",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            onChanged: null,
                            value: false,
                          ),
                          FlatButton(
                            child: const Text(
                              'Keep me Signed in',
                              style: TextStyle(fontSize: 13),
                            ),
                            onPressed: () {
                              /* ... */
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    Container top() {
      return Container(
        // width: double.infinity,
        height: 250,
        color: Colors.blue[700],
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
      );
    }

    return StyledToast(
      textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: Color(0x99000000),
      borderRadius: BorderRadius.circular(5.0),
      textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
      toastPositions: StyledToastPosition.bottom,
      toastAnimation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(seconds: 4),
      animDuration: Duration(seconds: 1),
      dismissOtherOnShow: true,
      movingOnWindowChange: true,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: <Widget>[
                    top(),
                    login(),
                  ],
                ),
        ),
      ),
    );
  }
}
