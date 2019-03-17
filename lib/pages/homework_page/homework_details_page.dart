import 'package:flutter/material.dart';
import '../../functions/subjects_map.dart';
import '../../functions/capitalize.dart';
import '../../widgets/information_list_tile.dart';

class DetailsPage extends StatefulWidget {

  final Map homeworkItem;
  final String displayDate;
  final String uniqueId;

  DetailsPage(this.homeworkItem, this.displayDate, this.uniqueId);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    Color _generateBackgroundColor(){
      if(widget.homeworkItem['homework_made'] == true){
        return Colors.green;
      }
      if(widget.homeworkItem['test'] == 'ja'){
        return Theme.of(context).accentColor;
      }
      return Theme.of(context).primaryColor;
    }

    Color bgColor = _generateBackgroundColor();
    return Hero(
      tag: widget.uniqueId,
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
            Container(
              height: MediaQuery.of(context).size.height * 0.24,
              padding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    subjectsMap[widget.homeworkItem['subject'].toLowerCase()] ?? widget.homeworkItem['subject'],
                    style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                  ),
                  Text(
                    capitalize(widget.displayDate) + (widget.homeworkItem['teacher'] != "" ? ", "  + capitalize(widget.homeworkItem['teacher']) : ""),
                    style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),
                  ),
                ],
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: bgColor),
                child: BottomInformationCard(widget.homeworkItem, bgColor)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomInformationCard extends StatelessWidget {

  final Map homeworkItem;
  final Color bgColor;
  BottomInformationCard(this.homeworkItem, this.bgColor);

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
          child: ListView(
            children: <Widget>[
              Padding(padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0), child: 
                  Text(homeworkItem['homework'], style: Theme.of(context).textTheme.body1.copyWith(fontSize: 14.5),)),
              Padding(padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0), child: Divider()),
              InformationListTile(leadingText: 'Toets?', titleText: capitalize(homeworkItem['test'])),
              InformationListTile(leadingText: 'Gemaakt?', titleText: homeworkItem['homework_made'] == true ? 'Ja' : 'Nee'),
            ],
          ),
        ),
      ),
    );
  }
}