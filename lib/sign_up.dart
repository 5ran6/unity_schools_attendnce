import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_schools_attendnce/dashboad_fab.dart';

class sign_up extends StatefulWidget {
//TODO: Password needs to have at least 6 characters
//TODO: Form Validation

  final String regNo;

  sign_up({Key key, @required this.regNo}) : super(key: key);

  @override
  _sign_upState createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  final focus1 = FocusNode();

  final focus2 = FocusNode();

  final focus3 = FocusNode();

  final focus4 = FocusNode();

  final focus5 = FocusNode();

  final focus6 = FocusNode();

  bool _isLoading = false;
  var error = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();
  TextEditingController _childCodeController = new TextEditingController();

  //strings to save state
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  String phone;

  signUp(String code, String firstname, String lastname, String email,
      String password, String password_confirmation, String phone) async {
    Map data = {
      'code': code.trim(),
      'firstname': firstname.trim(),
      'lastname': lastname.trim(),
      'email': email.trim(),
      'password': password.trim(),
      'password_confirmation': password_confirmation.trim(),
      'phone': phone.trim()
    };

    var jsonData;
    var response = await http.post(
        "https://gamint-bimiis.com.ng/api/parent-registration",
        body: data);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print('Status Code = ' + response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      jsonData = json.decode(response.body);
      print('success: ' + response.body);
      setState(() {
        _isLoading = false;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => FancyFab()),
            (Route<dynamic> route) => false);
      });
    } else {
      try {
        jsonData = json.decode(response.body);
        print('failed: ' + response.body);
        if (response.statusCode == 422) {
          //user not found prompt
          setState(() {
            if (jsonData['errors']['email'].toString() != 'null') {
              error = jsonData['errors']['email'].toString().substring(
                  1, jsonData['errors']['email'].toString().length - 1);
            } else if (jsonData['errors']['user'].toString() != 'null') {
              print('reached here');
              error = jsonData['errors']['user'].toString().substring(
                  1, jsonData['errors']['user'].toString().length - 1);
            } else {
              error = jsonData['message'].toString();
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
        }
      } on FormatException catch (exception) {
        print('Exception: ' + exception.toString());
        print('Error' + response.body);
        error = 'Oops! Something went wrong.';
        setState(() {
          _isLoading = false;
        });
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
      }
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

  @override
  Widget build(BuildContext context) {
//signUp function

    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
              : ListView(
                  children: <Widget>[
                    SizedBox(height: 30), //space
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 18, 10, 2),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign Up\n_____",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: new Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: Card(
                          //   key: _formKey,

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const ListTile(
                                leading: Icon(Icons.all_inclusive),
                                title: Text('Franship 101'),
                                subtitle: Text(
                                    'Welcome to Franship 101. Your mind controls your life. Sign in to access contents that will enrich your mind today'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextFormField(
                                  onSaved: (String value) {
                                    firstName = value;
                                  },
                                  controller: _firstNameController,
                                  textCapitalization: TextCapitalization.words,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(focus1);
                                  },
                                  textInputAction: TextInputAction.next,
                                  validator: _validateFirstName,
                                  autofocus: true,
                                  style: TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      labelText: 'First Name',
                                      labelStyle:
                                          TextStyle(color: Colors.black54),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextFormField(
                                  validator: _validateLastName,
                                  onSaved: (String value) {
                                    lastName = value;
                                  },
                                  controller: _lastNameController,
                                  textCapitalization: TextCapitalization.words,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(focus2);
                                  },
                                  focusNode: focus1,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      labelText: 'Last Name',
                                      labelStyle:
                                          TextStyle(color: Colors.black54),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextFormField(
                                  onSaved: (String value) {
                                    email = value;
                                  },
                                  validator: _validateEmail,
                                  controller: _emailController,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(focus3);
                                  },
                                  focusNode: focus2,
                                  style: TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle:
                                          TextStyle(color: Colors.black54),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextFormField(
                                  onSaved: (String value) {
                                    password = value;
                                  },
                                  validator: _validatePassword,
                                  controller: _passwordController,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(focus4);
                                  },
                                  focusNode: focus3,
                                  obscureText: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle:
                                          TextStyle(color: Colors.black54),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextFormField(
                                  onSaved: (String value) {
                                    confirmPassword = value;
                                  },
                                  validator: _validateConfirmPassword,
                                  controller: _confirmPasswordController,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(focus5);
                                  },
                                  focusNode: focus4,
                                  obscureText: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      labelStyle:
                                          TextStyle(color: Colors.black54),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextFormField(
                                  onSaved: (String value) {
                                    phone = value;
                                  },
                                  controller: _phoneController,
                                  textInputAction: TextInputAction.done,
                                  validator: _validatePhone,
                                  focusNode: focus5,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      labelText: 'Phone number',
                                      hintText: '080xxxxxxxx',
                                      labelStyle:
                                          TextStyle(color: Colors.black54),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextFormField(
                                  initialValue: '${widget.regNo}'.toUpperCase(),
                                  enabled: false,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(
                                    color: Colors.deepPurple[900],
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      labelText: 'Child Code',
                                      labelStyle:
                                          TextStyle(color: Colors.black54),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              ButtonBar(
                                children: <Widget>[
                                  FlatButton(
                                    child: const Text(
                                      'Already have an account?',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    onPressed: () {
                                      /* ... */
                                    },
                                  ),
                                  FlatButton(
                                    color: Colors.grey[200],
                                    child: const Text('SIGN IN'),
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
                    MaterialButton(
                      color: Colors.blue,
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: _validateInputs,
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Enter a valid Email address';
  }

  String _validatePassword(String value) {
    if (value.length > 5) {
      return null;
    }

    return 'Password must be upto 6 characters';
  }

  String _validateConfirmPassword(String value) {
    if (value.length > 5 && value == _passwordController.text) {
      return null;
    }
    return 'Passwords must match';
  }

  String _validatePhone(String value) {
    if (value.length > 10 && value.length < 16) {
      return null;
    }
    return 'Enter a valid phone number';
  }

  String _validateFirstName(String value) {
    if (value.length > 0) {
      return null;
    }

    return 'Please enter a First Name';
  }

  String _validateLastName(String value) {
    if (value.length > 0) {
      return null;
    }

    return 'Please enter a Last Name';
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate()) {
      // Text forms has validated.
      // Every of the data in the form are valid at this point
      form.save();
//      showDialog(
//          context: context,
//          builder: (BuildContext context) =>
//          new AlertDialog(
//            content: new Text("Processing registration...."),
//          ));
      setState(() {
        _isLoading = true;
      });
      signUp(
          widget.regNo.trim(),
          _firstNameController.text.trim().toUpperCase(),
          _lastNameController.text.trim().toUpperCase(),
          _emailController.text.trim().toUpperCase(),
          _passwordController.text.trim(),
          _confirmPasswordController.text.trim(),
          _phoneController.text.trim());
    } else {
      setState(() => _autoValidate = true);
    }
  }

  void _showSnackBar(message) {
    final snackBar = new SnackBar(
      content: new Text(message),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
