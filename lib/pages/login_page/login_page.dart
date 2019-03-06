import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import '../../functions/request.dart';
import 'store_login_response_data.dart';

import '../../widgets/loading_animation.dart';

import '../../functions/convert_to_bool.dart';



const String sec_msg_short = 
"""
Zodra jij inlogt wordt je wachtwoord heel even gebruikt om een zermelo-koppelingscode op te halen. Deze is nodig voor het verkrijgen van je rooster. Je wachtwoord word daarna ge-encrypt opgeslagen, de sleutel wordt verwijderd van de server en naar je mobiel gestuurd. 
Dit betekent dat zowel de server als je telefoon (en dus elke app op je telefoon) niet bij je wachtwoord kan, behalve als jij, via deze app, een verzoek stuurt naar de server. Dit doe je bijvoorbeeld als je je cijfers laadt.
""";

const String sec_msg_long_1 =
"""
Wanneer er wordt ingelogd wordt je wachtwoord gebruikt om je identiteit te controleren door middel van een login op de Zermelo API. Als de combinatie van je wachtwoord en gebruikersnaam correct is wordt er een uniek ID gegenereerd. Dit ID word gebruikt om je identieit te confirmeren met de server in latere requests. Je wachtwoord wordt na het inloggen ge-encrypt op de server opgeslagen. Hiervoor wordt het AES-256 algoritme gebruikt. De key wordt daarna naar je mobiel gestuurd en wordt NOOIT opgeslagen op de server.
""";

const String sec_msg_long_2 =
"""
Het gevolg hiervan is dat zowel de server als de client (deze app/je telefoon) niet zonder elkaar bij je wachtwoord kunnnen. Dit betekent dat voor een aantal requests, bijvoorbeeld voor je cijfers, bestanden en andere informatie van leerlingweb, de key vanaf je mobiel naar de server wordt gestuurd. De server gebruikt de key om je wachtwoord kort te decrypten en zo in te loggen op de service waar het de data vandaan haalt. Het gedecrypte wachtwoord wordt niet opgeslagen.
""";

const String sec_msg_long_3 = 
"""
Je gegevens worden gehaald vanaf verschillende punten; Zermelo API, Leerlingweb, SOM-implementatie op Leerlingweb, ItsLearning en IchthusDrive. Voor alle datapunten, met uitzondering van de Zermelo API, is je wachtwoord elke keer opnieuw nodig. Dit is de reden dat je wachtwoord niet gehasht maar ge-encrypt wordt.
Al deze gegevens worden verzameld en opgeslagen op de server, om vanaf daar naar je mobiel verzonden te worden. Dit is helaas nodig omdat het ophalen van sommige data langer dan 5 minuten kan duren. De server zorgt ervoor dat dit wordt gedaan voordat jij het nodig hebt, zodat wanneer jij het nodig hebt de server alleen de gecachde data hoeft te versturen. 
""";

const String sec_msg_long_4 = 
"""
Verder wordt praktisch alle data, behalve natuurlijk je wachtwoord, op je mobiel opgeslagen. Dit gebeurd op een plek waar, op niet geunlockte telefoons, alleen deze app bij kan. Dit wordt gedaan zodat je ook je roosters en cijfers kunt bekijken zonder een internetverbinding. Ook wordt de lokale data gebruikt door algorithmes die proberen een goede balans te vinden tussen snelheid en recentheid van data bij langzame verbindingen.
""";

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
  final GlobalKey<ScaffoldState> _loginPageScaffoldKey =
      GlobalKey<ScaffoldState>();
  bool isLoading = false;
  var name = "Leerlingnummer";

  void resolveUsercode() async {
    var userName;
    if (_loginData.leerlingnummer != null) {
      userName = await getDataFromAPI(
          '/resolve/ln', {'q': _loginData.leerlingnummer},
          useSessionData: false);
      //log event
      widget.fbAnalytics.logEvent(name: 'usercode_submitted');
    } else {
      userName = null;
    }
    if (userName == "") {
      userName = "Leerlingnummer";
    }
    setState(() {
      name = userName;
    });
  }

  void checkCredentials() async {
    //logevent
    widget.fbAnalytics.logEvent(name: 'credentials_submitted');

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
      if (convertToBool(loginResponseData["success"])) {
        widget.fbAnalytics.logLogin();
        loginResponseData["userCode"] = credentials["userCode"];
        try{Navigator.pop(GlobalObjectKey("login_sec_modalBottomSheet").currentContext);}catch(e){print(e);}
        storeLoginResponseData(loginResponseData);
        Navigator.pushReplacementNamed(context, '/schedule');
      } else {
        setState(() {
          isLoading = false;
        });
        _loginPageScaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Leerlingnummer of wachtwoord incorrect."),
        ));
      }
    } catch (e) {
      _loginPageScaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
            "Er is iets fout gegaan. Controleer je gegevens en internetverbinding en probeer het opnieuw."),
      ));
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
      key: _loginPageScaffoldKey,
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
          ];
        },
        body: Center(
          child: UserLoginInput(isLoading, name, resolveUsercode, widget.fbAnalytics),
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
  final FirebaseAnalytics fbAnalytics;
  UserLoginInput(this.isLoading, this.name, this.callBack, this.fbAnalytics);

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
          )
        ),
        Padding(child: Divider(), padding: EdgeInsets.only(top: 16.0)),
        FlatButton(
          child: Align(child: Text("Lees meer over de veiligheid van deze app en je gegevens...", style: Theme.of(context).textTheme.caption.copyWith(fontSize: 12.0)), alignment: Alignment.centerLeft),
          onPressed: (){
            widget.fbAnalytics.logEvent(name: 'opened_security_info');
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context){
                return ListView(
                  key: GlobalObjectKey('login_sec_modalBottomSheet'),
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    Text("In het kort", style: Theme.of(context).textTheme.body2),
                    Text(sec_msg_short),
                    Divider(),
                    Text("De wat langere uitleg", style: Theme.of(context).textTheme.body2),
                    Text(sec_msg_long_1),
                    Text(sec_msg_long_2),
                    Text(sec_msg_long_3),
                    Text(sec_msg_long_4),
                  ],
                );
              }
            );
          },
        )
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
