import 'package:flutter/material.dart';
import '../../functions/logout.dart';

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
