import 'package:flutter/material.dart';

class Check_admission_number extends StatefulWidget {
  @override
  _Check_admission_numberState createState() => _Check_admission_numberState();
}

class _Check_admission_numberState extends State<Check_admission_number> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
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
            Expanded(
              child: Container(
                //height: MediaQuery.of(context).size.height - 150.0,
                color: Colors.lightBlue[300],
                child:Card(

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
