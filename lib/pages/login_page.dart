import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
          child: UserLoginInput(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: InkWell(
          onTap: (){print('test');},
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

class _LoginData {
  String leerlingnummer = '';
  String password = '';
}

class UserLoginInput extends StatefulWidget {
  @override
  _UserLoginInputState createState() => _UserLoginInputState();
}

class _UserLoginInputState extends State<UserLoginInput> {
  bool isLoading = true;

  final loginUserCodeController = TextEditingController();
  final loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var progressIndicator = isLoading ? LinearProgressIndicator() : Container();

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
                    maxLength: 6,
                    maxLines: 1,
                    controller: loginUserCodeController,
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 16.0),
                    decoration: InputDecoration(
                        labelText: "Leerlingnummer",
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
    loginUserCodeController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }
}
