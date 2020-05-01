import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sign_up extends StatelessWidget {
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final String regNo;

  sign_up({Key key, @required this.regNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextEditingController _firstNameController = new TextEditingController();
    TextEditingController _lastNameController = new TextEditingController();
    TextEditingController _emailController = new TextEditingController();
    TextEditingController _phoneController = new TextEditingController();
    TextEditingController _passwordController = new TextEditingController();
    TextEditingController _confirmPasswordController = new TextEditingController();
    TextEditingController _childCodeController = new TextEditingController();

//    signUp(String email, String password) async {
//      Map data = {'email': email, 'password': password};
//
//      var jsonData;
//      var response =
//      await http.post("https://gamint-bimiis.com.ng/api/login", body: data);
//      SharedPreferences sharedPreferences =
//      await SharedPreferences.getInstance();
//
//      if (response.statusCode == 201) {
//        jsonData = json.decode(response.body);
//        print('success: ' + response.body);
//        setState(() {
//          _isLoading = false;
//          sharedPreferences.setString("token", jsonData['token']);
//          Navigator.of(context).pushAndRemoveUntil(
//              MaterialPageRoute(builder: (BuildContext context) => FancyFab()),
//                  (Route<dynamic> route) => false);
//        });
//      } else {
//        jsonData = json.decode(response.body);
//        print('failed: ' + response.body);
//        if (jsonData['status_code'] == 422) {
//          //user not found prompt
//          setState(() {
//            error = 'User not found.';
//            _isLoading = false;
//
//            showToast('$error',
//                context: context,
//                animation: StyledToastAnimation.slideFromTop,
//                reverseAnimation: StyledToastAnimation.slideToTop,
//                position: StyledToastPosition.top,
//                startOffset: Offset(0.0, -3.0),
//                reverseEndOffset: Offset(0.0, -3.0),
//                duration: Duration(seconds: 4),
//                //Animation duration   animDuration * 2 <= duration
//                animDuration: Duration(seconds: 1),
//                curve: Curves.elasticOut,
//                reverseCurve: Curves.fastOutSlowIn);
//          });
//        } else {
//          //Something went wrong prompt
//          setState(() {
//            error = 'Oops! Something went wrong.';
//            _isLoading = false;
//            showToast('$error',
//                context: context,
//                animation: StyledToastAnimation.slideFromTop,
//                reverseAnimation: StyledToastAnimation.slideToTop,
//                position: StyledToastPosition.top,
//                startOffset: Offset(0.0, -3.0),
//                reverseEndOffset: Offset(0.0, -3.0),
//                duration: Duration(seconds: 4),
//                //Animation duration   animDuration * 2 <= duration
//                animDuration: Duration(seconds: 1),
//                curve: Curves.elasticOut,
//                reverseCurve: Curves.fastOutSlowIn);
//          });
//        }
//      }
//    }


    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ListView(
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
                         controller: _firstNameController,
                          textCapitalization: TextCapitalization.words,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focus1);
                          },
//                          validator: (value) {
//                            if (value.isEmpty) {
//                              return 'Please enter some text';
//                            }
//                            return null;
//                          },
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(

                              labelText: 'First Name',
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
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
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
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
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
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
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
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
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          enabled: true,
                          controller: _phoneController,
                          textInputAction: TextInputAction.done,
                          focusNode: focus5,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'Phone number',
                              hintText: '080xxxxxxxx',
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          initialValue: '$regNo'.toUpperCase(),
                          enabled: false,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                            color: Colors.deepPurple[900],
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: 'Child Code',
                              labelStyle: TextStyle(color: Colors.black54),
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
              MaterialButton(
                color: Colors.blue,
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
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
}
