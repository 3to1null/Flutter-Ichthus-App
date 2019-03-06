import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import '../drawer/drawer.dart';
import '../../models/user_model.dart';
import '../../functions/request.dart';

class FeedbackPage extends StatefulWidget {

  FeedbackPage(this.fbAnalytics, this.fbObserver);

  final FirebaseAnalytics fbAnalytics;
  final FirebaseAnalyticsObserver fbObserver;

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  String feedbackMessage;
  bool hasSendFeedback = false;

  @override
  Widget build(BuildContext context) {

  widget.fbAnalytics.logEvent(name: 'feedbackpage_open');

    return Scaffold(
      drawer: CompleteDrawer(widget.fbAnalytics, widget.fbObserver),
      appBar: AppBar(title: Text('Feedback')),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            'Vind je iets aan deze app tof, of juist heel slecht? Wil je graag een nieuwe functie zien? Vertel het mij hier!',
            style: Theme.of(context).textTheme.subtitle,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Typ hier je feedback...'
            ),
            maxLines: null,
            maxLength: 1200,
            onChanged: (String text){
              feedbackMessage = text;
              if(hasSendFeedback){
                setState(() {
                   hasSendFeedback = false; 
                });
              }
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: !hasSendFeedback ? RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('Verstuur feedback'),
              onPressed: (){
                setState(() {
                 hasSendFeedback = true; 
                });
                widget.fbAnalytics.logEvent(name: 'feedback_sent');
                sendFeedback(feedbackMessage);
              },
            ) : Text('Feedback verzonden, bedankt!'),
          )
        ],
      ),
    );
  }
}

void sendFeedback(String feedbackMessage) async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
  Map<String, dynamic> deviceInfoMap = {
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
    };
    String deviceInfo = json.encode(deviceInfoMap);
    String userInfo = UserModel().toJSONString();

    await getDataFromAPI('/feedback/get', {'fb_msg': feedbackMessage, 'u_info': userInfo, 'device_info': deviceInfo});

}