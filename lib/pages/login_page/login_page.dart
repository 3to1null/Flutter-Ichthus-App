import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import '../../functions/request.dart';
import 'store_login_response_data.dart';

import '../../widgets/loading_animation.dart';

import '../schedule_page/schedule_page.dart';

class _LoginData {
  String leerlingnummer = '';
  String password = '';
}

var _loginData = _LoginData();

class LoginPage extends StatelessWidget {

  LoginPage(this.fbAnalytics, this.fbObserver);

  final FirebaseAnalytics fbAnalytics;
  final FirebaseAnalyticsObserver fbObserver;

  @override
  Widget build(BuildContext context) {
    return ActualLoginPage(fbAnalytics, fbObserver);
  }
}

class ActualLoginPage extends StatefulWidget {

  ActualLoginPage(this.fbAnalytics, this.fbObserver);

  final FirebaseAnalytics fbAnalytics;
  final FirebaseAnalyticsObserver fbObserver;

  @override
  _ActualLoginPageState createState() => _ActualLoginPageState();
}

class _ActualLoginPageState extends State<ActualLoginPage> {
  bool isLoading = false;
  var name = "Leerlingnummer";

  void resolveUsercode() async {
    var userName;
    if (_loginData.leerlingnummer != null) {
      userName = await getDataFromAPI(
          '/resolve/ln', {'q': _loginData.leerlingnummer},
          useSessionData: false);
    } else {
      userName = null;
    }
    if(userName == ""){
      userName = "Leerlingnummer";
    }
    setState(() {
      name = userName;
    });
  }

  void checkCredentials() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> credentials = {
      "userCode": _loginData.leerlingnummer.toString(),
      "password": _loginData.password.toString()
    };
    var response =
        await postDataToAPI('/login', credentials, useSessionData: false);
    final Map loginResponseData = json.decode(response);
    try {
      if (loginResponseData["success"]) {
        loginResponseData["userCode"] = credentials["userCode"];
        storeLoginResponseData(loginResponseData);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SchedulePage(widget.fbAnalytics, widget.fbObserver)));
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              //expandedHeight: 200.0,
              expandedHeight: screenHeight * 0.26,
              elevation: 2.0,
              forceElevated: true,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text("Inloggen",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      )),
                  background: Image.asset(
                    "lib/img/ichthusBG.jpg",
                    fit: BoxFit.cover,
                    color: Colors.black54,
                    colorBlendMode: BlendMode.overlay,
                  )),
            ),
            //LinearProgressIndicator(),
          ];
        },
        body: Center(
          child: UserLoginInput(isLoading, name, resolveUsercode),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            firstChild: LoginButton(checkCredentials),
            secondChild: LoginButtonLoading(),
            crossFadeState: !isLoading
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          )),
    );
  }
}

class UserLoginInput extends StatefulWidget {
  final bool isLoading;
  final dynamic name;
  final dynamic callBack;
  UserLoginInput(this.isLoading, this.name, this.callBack);

  @override
  _UserLoginInputState createState() => _UserLoginInputState();
}

class _UserLoginInputState extends State<UserLoginInput> {
  final loginUserCodeController = TextEditingController();
  final loginPasswordController = TextEditingController();

  void _userCodeChangeListener() {
    if (loginUserCodeController.text.length == 6 &&
        _loginData.leerlingnummer != loginUserCodeController.text) {
      _loginData.leerlingnummer = loginUserCodeController.text;
      widget.callBack();
    } else if (loginUserCodeController.text.length != 6) {
      _loginData.leerlingnummer = null;
      widget.callBack();
    }
  }

  void _passwordChangeListener() {
    if (loginPasswordController.text != _loginData.password) {
      _loginData.password = loginPasswordController.text;
    }
  }

  @override
  void initState() {
    super.initState();
    loginUserCodeController.addListener(_userCodeChangeListener);
    loginPasswordController.addListener(_passwordChangeListener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //padding: EdgeInsets.symmetric(),
        child: ListView(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.person, color: Theme.of(context).primaryColor),
                Spacer(),
                Expanded(
                  flex: 10,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    maxLines: 1,
                    controller: loginUserCodeController,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 16.0),
                    decoration: InputDecoration(
                        labelText: widget.name == null
                            ? "Leerlingnummer"
                            : widget.name,
                        contentPadding: EdgeInsets.all(2.5)),
                  ),
                ),
              ],
            )),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.lock, color: Theme.of(context).primaryColor),
                Spacer(),
                Expanded(
                  flex: 10,
                  child: TextField(
                    obscureText: true,
                    maxLines: 1,
                    controller: loginPasswordController,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 16.0),
                    decoration: InputDecoration(
                        labelText: "Wachtwoord",
                        contentPadding: EdgeInsets.all(2.5)),
                  ),
                ),
              ],
            )),
      ],
    ));
  }

  @override
  void dispose() {
    loginUserCodeController.removeListener(_userCodeChangeListener);
    loginUserCodeController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }
}

class LoginButtonLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.0,
      child: LoadingAnimation(34.0),
    );
  }
}

class LoginButton extends StatelessWidget {
  final dynamic loginCallBack;

  LoginButton(this.loginCallBack);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        loginCallBack();
      },
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: SizedBox(
          height: 48.0,
          child: Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "LOG IN",
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Icon(Icons.navigate_next,
                    color: Theme.of(context).primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
