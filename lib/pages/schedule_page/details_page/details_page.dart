import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../schedule_widget_functions.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../functions/subjects_map.dart';
import '../../../functions/capitalize.dart';



class DetailsPage extends StatefulWidget {
  final Appointment appointment;
  DetailsPage(this.appointment);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    Color bgColor = appointmentBackgroundColor(widget.appointment, 0);
    return Hero(
      tag: widget.appointment.uniqueId,
      child: Scaffold(
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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.24,
                padding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 32.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  subjectsMap[widget.appointment.subjects[0].toLowerCase()] ?? widget.appointment.subjects[0],
                  style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context).copyWith(
                  accentColor: bgColor,                ),
                child: BottomInformationCard(widget.appointment, bgColor)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomInformationCard extends StatelessWidget {

  final Appointment appointment;
  final Color bgColor;
  BottomInformationCard(this.appointment, this.bgColor);

  @override
  Widget build(BuildContext context) {
    String displayExtraInformation(){
      if(appointment.cancelled){
        return "Deze les is uitgevallen.";
      }
      if(appointment.extraMessage.isNotEmpty){
        return appointment.extraMessage;
      }
      return "";
    }

    String dateTimeInformation(){
      const List<String> months = ['Januari', 'Februari', 'Maart', 'April', 'Mei',
      'Juni', 'Juli', 'Augustus', 'September', 'Oktober', 'November', 'December'];
      const List<String> weekDays = ['Maandag', 'Dinsdag', 'Woensdag', 'Donderdag', 'Vrijdag', 'Zaterdag', 'Zondag'];
      DateTime startTime = DateTime.fromMillisecondsSinceEpoch(appointment.start * 1000);
      DateTime endTime = DateTime.fromMillisecondsSinceEpoch(appointment.end * 1000);
      String dag = weekDays[startTime.weekday - 1];
      String dagNummer = startTime.day.toString();
      String maand = months[startTime.month - 1];
      String startMinuut = startTime.minute.toString();
      if(startMinuut.length == 1){startMinuut += "0";}
      String eindMinuut = endTime.minute.toString();
      if(eindMinuut.length == 1){eindMinuut += "0";}
      String beginTijd = "${startTime.hour.toString()}:$startMinuut";
      String eindTijd = "${endTime.hour.toString()}:$eindMinuut";
      return "$beginTijd - $eindTijd\n$dag $dagNummer $maand";
    }

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
          child: ListView(
            children: <Widget>[
              (displayExtraInformation() != "") ? ListTile(
                leading: Icon(Icons.info, color: bgColor),
                title: Text(displayExtraInformation()),
              ) : Container(),
              (appointment.teachers.isNotEmpty) ? ListTile(
                leading: Icon(Icons.person, color: bgColor,),
                title: Text(
                  capitalize(appointment.teachersFullnames.join(', '))
                ),
              ) : Container(),
              ListTile(
                leading: Icon(Icons.calendar_today, color: bgColor,),
                title: Text(dateTimeInformation()),
              ),
              (appointment.locations.isNotEmpty) ? ListTile(
                leading: Icon(Icons.location_on, color: bgColor,),
                title: Text(
                  (appointment.locations.join(', ')).toUpperCase()
                ),
              ) : Container(),
            (appointment.groups.isNotEmpty) ? ListTile(
                leading: Icon(Icons.group, color: bgColor,),
                title: Text(
                  (appointment.groups.join(', ')).toUpperCase()
                ),
              ) : Container(),
            (appointment.teachers.isNotEmpty) ? OutlineButton(
              highlightedBorderColor: Colors.transparent,
              child: Text("Mail docent"),
              onPressed: (){_openTeacherMail(appointment.teachers[0], appointment.teachersFullnames[0]);},
            ) :Container()
            ],
          ),
        ),
      ),
    );
  }
}

void _openTeacherMail(teacherAbr, teacherFullname) async {
  teacherFullname =capitalize(teacherFullname);
  String emailUrl = "mailto:$teacherAbr@ichthuscollege.nl?body=Beste%20$teacherFullname,";
  if (await canLaunch(emailUrl)) {
    await launch(emailUrl);
  }

}