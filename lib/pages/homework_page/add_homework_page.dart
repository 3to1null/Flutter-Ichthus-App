import 'package:flutter/material.dart';
import 'add_form_widgets/add_homework_form.dart';
import 'add_form_widgets/form_data.dart';

class AddHomeworkPage extends StatefulWidget {

  AddHomeworkPage();

  @override
  _AddHomeworkPageState createState() => _AddHomeworkPageState();
}

class _AddHomeworkPageState extends State<AddHomeworkPage> {

  @override
  void initState() {
    super.initState();
    formData = {
      "subject": "",
      "date": "",
      "hour": "",
      "homework": "",
      "is_for_group": true
    };
  }

  @override
  Widget build(BuildContext context) {
    Color _generateBackgroundColor(){
      return Theme.of(context).accentColor;
    }

    Color bgColor = _generateBackgroundColor();
    return Hero(
      tag: "_AddHomeWorkFABPageHero",
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: bgColor,
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: BackButton(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.24,
              padding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 32.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                "Nieuw huiswerk",
                style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: bgColor),
                child: BottomInformationCard(bgColor)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomInformationCard extends StatelessWidget {

  final Color bgColor;
  BottomInformationCard(this.bgColor);

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
          )
      ),
      margin: EdgeInsets.all(0),
      elevation: 3.0,
      child: Container(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.24,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: AddHomeworkForm(),
        ),
      ),
    );
  }
}