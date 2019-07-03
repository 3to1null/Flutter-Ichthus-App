import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../functions/request.dart';
import '../../../widgets/loading_animation.dart';
import 'dart:convert';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class NotificationConsentDialog extends StatefulWidget {
  final BuildContext context;
  NotificationConsentDialog(this.context);

  @override
  _NotificationConsentDialogState createState() => _NotificationConsentDialogState();
}

class _NotificationConsentDialogState extends State<NotificationConsentDialog> {

  Future getInfo;
  bool isChecked;

  @override
  void initState() {
    getInfo = getDataFromAPI('/marks/consent', {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Center(child: Text('Cijfer notificaties', style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.w600))),
      content: FutureBuilder(
        future: getInfo,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done: {
              Map data = json.decode(snapshot.data);
              String info = data['info'];
              isChecked ??= data['notifs'] != null ? data['notifs'] : false;
              return SizedBox(
                height: 340.0,
                width: 200.0,        
                child: ListView(
                  children: <Widget>[
                    Text(info),
                    CheckboxListTile(
                      title: Text('Cijfer Notificaties:'),
                      value: isChecked,
                      onChanged: (value) async {
                        postDataToAPI("/marks/consent", {'notifs': value ? 'true' : 'false', 'fcmToken': await _firebaseMessaging.getToken()});
                        setState(() {
                         isChecked = value; 
                        });
                      },
                    )
                  ],
                ),
              );
            } 
            default: return SizedBox(
              height: 120.0,
              child: LoadingAnimation(40.0)
            );
          }
        },
      ),
    );
  }
}