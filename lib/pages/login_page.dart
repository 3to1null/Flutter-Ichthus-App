import 'package:flutter/material.dart';

import '../functions/request.dart';

class _LoginData {
  String leerlingnummer = '';
  String password = '';
}

var _loginData = _LoginData();

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ActualLoginPage();
  }
}

class ActualLoginPage extends StatefulWidget {
  @override
  _ActualLoginPageState createState() => _ActualLoginPageState();
}

class _ActualLoginPageState extends State<ActualLoginPage> {
    var isLoading = false;
    var name = "Leerlingnummer";

  void resolveUsercode() async {
    final userName = await getDataFromAPI('/resolve/ln', {'q': _loginData.leerlingnummer});
    setState(() {
          name = userName;
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
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
                  background: Image.network(
                    "https://bia.nl/wp-content/uploads/2017/08/ichthus1.jpg",
                    fit: BoxFit.cover,
                    color: Colors.black54,
                    colorBlendMode: BlendMode.overlay,
                  )),
            ),
          ];
        },
        body: Center(
          child: UserLoginInput(isLoading, name, resolveUsercode),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: InkWell(
          onTap: (){resolveUsercode();},
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
                      style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    Icon(Icons.navigate_next, color: Theme.of(context).primaryColor),
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

  void _userCodeChangeListener(){
    if(loginUserCodeController.text.length == 6 && _loginData.leerlingnummer != loginUserCodeController.text){
      _loginData.leerlingnummer = loginUserCodeController.text;
      widget.callBack();
    }
  }

  @override
  void initState(){
    super.initState();
    loginUserCodeController.addListener(_userCodeChangeListener);
  }
  

  @override
  Widget build(BuildContext context) {
    var progressIndicator = widget.isLoading ? LinearProgressIndicator() : Container();

    return Container(
        //padding: EdgeInsets.symmetric(),
        child: ListView(
      children: <Widget>[
        progressIndicator,
        Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.person, color: Theme.of(context).primaryColor),
                Spacer(),
                Expanded(
                  flex: 10,
                  child: TextField(
                    maxLength: 6,
                    maxLines: 1,
                    controller: loginUserCodeController,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 16.0),
                    decoration: InputDecoration(
                        labelText: widget.name == null ? "Leerlingnummer" : widget.name,
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