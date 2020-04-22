import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sign_up extends StatelessWidget {
  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  elevation: 20,
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
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).nextFocus();
                          },
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).nextFocus();
                          },

                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).nextFocus();
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).nextFocus();
                          },

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
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).nextFocus();
                          },

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
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).nextFocus();
                          },

                          style: TextStyle(
                            color: Colors.deepPurple[900],
                          ),
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
                onPressed: () {},
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
