import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:unity_schools_attendnce/bottom_sheet.dart';

final bSheet = bottomSheet();

class FancyFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

//  FancyFab(this.bSheet, this.onPressed, this.tooltip, this.icon);

  FancyFab({this.onPressed, this.tooltip, this.icon});

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  bool _isVisible = false;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
    _isVisible = !_isVisible;
  }

  Widget add() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Visibility(
          visible: _isVisible,
          child: Text(
            "Add Child ",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: FloatingActionButton(
            onPressed: () {
              bSheet.settingModalBottomSheet(context);
            },
            tooltip: 'Add',
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget settings() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Visibility(
          visible: _isVisible,
          child: Text(
            "Settings ",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: FloatingActionButton(
            onPressed: null,
            tooltip: 'Settings',
            child: Icon(Icons.settings),
          ),
        ),
      ],
    );
  }

  Widget inbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Visibility(
          visible: _isVisible,
          child: Text(
            "Inbox ",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: FloatingActionButton(
            onPressed: null,
            tooltip: 'Inbox',
            child: Icon(Icons.mail),
          ),
        ),
      ],
    );
  }

  Widget toggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          child: FloatingActionButton(
            backgroundColor: _buttonColor.value,
            onPressed: animate,
            tooltip: 'Toggle',
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _animateIcon,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildFrontWidget(int index) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: new ExactAssetImage('assets/logo.png'),
                        backgroundColor: Colors.white70,
                        radius: 26.0,
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2,
                      width: 20,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Abraham Udele ",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "FGC Vandekya, Benue ",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "Male ",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                  ],
                ),
                FlatButton(
                  onPressed: () {
                    SimpleFoldingCellState foldingCellState =
                        context.ancestorStateOfType(
                            TypeMatcher<SimpleFoldingCellState>());
                    foldingCellState?.toggleFold();
                  },
                  child: Text(
                    "View Details",
                  ),
                  textColor: Colors.white,
                  color: Colors.indigoAccent,
                  splashColor: Colors.white.withOpacity(0.5),
                )
              ],
            ));
      },
    );
  }

  Widget details(
    i,
  ) {}

  Widget _buildInnerTopWidget(int index) {
    return Container(
        color: Colors.blueGrey[100],
        alignment: Alignment.center,
        child: Text("TITLE - $index",
            style: TextStyle(
                color: Color(0xFF2e282a),
                fontFamily: 'OpenSans',
                fontSize: 20.0,
                fontWeight: FontWeight.w800)));
  }

  Widget _buildInnerBottomWidget(int index) {
    return Builder(builder: (context) {
      return Container(
        color: Color(0xFFecf2f9),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Other Attendance",
                ),
                textColor: Colors.white,
                color: Colors.indigoAccent,
                splashColor: Colors.white.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: FlatButton(
                onPressed: () {
                  SimpleFoldingCellState foldingCellState =
                      context.ancestorStateOfType(
                          TypeMatcher<SimpleFoldingCellState>());
                  foldingCellState?.toggleFold();
                },
                child: Text(
                  "Close",
                ),
                textColor: Colors.indigoAccent,
                color: Colors.white,
                splashColor: Colors.white.withOpacity(0.5),
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue[800]));
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
                child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return SimpleFoldingCell(
                          frontWidget: _buildFrontWidget(index),
                          innerTopWidget: _buildInnerTopWidget(index),
                          innerBottomWidget: _buildInnerBottomWidget(index),
                          cellSize:
                              Size(MediaQuery.of(context).size.width, 125),
                          padding: EdgeInsets.all(15),
                          animationDuration: Duration(milliseconds: 300),
                          borderRadius: 10,
                          onOpen: () => print('$index cell opened'),
                          onClose: () => print('$index cell closed'));
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 3.0,
              0.0,
            ),
            child: add(),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 2.0,
              0.0,
            ),
            child: inbox(),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value,
              0.0,
            ),
            child: settings(),
          ),
          toggle(),
        ],
      ),
    );
  }
}
