import 'package:flutter/material.dart';
import 'logout.dart';

void logoutGuider(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Uitloggen"),
          content: Text(
              "Als je uitlogt worden alle opgeslagen gegevens verwijderd. Na het uitloggen sluit de app af."),
          actions: <Widget>[
            FlatButton(
              child: Text("Blijf ingelogd"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Uitloggen"),
              textColor: Colors.red,
              onPressed: logout,
            ),
          ],
        );
      });
}

void forceLogoutGuider(context, {String customMessage, String customTitle, bool noDisplay: false}) {
  if(noDisplay){logout();}
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(customTitle ?? "Fout:"),
          content: Text(
              customMessage ??
              "De data op je mobiel is niet gelijk aan de data op de server. Je wordt nu uitgelogd en de app wordt afgesloten. Je kan de app daarna opnieuw starten."
            ),
          actions: <Widget>[
            FlatButton(
              child: Text("Uitloggen"),
              textColor: Colors.red,
              onPressed: logout,
            ),
          ],
        ),
      );
    });
}