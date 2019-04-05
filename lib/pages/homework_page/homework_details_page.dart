import 'package:flutter/material.dart';
import '../../functions/subjects_map.dart';
import '../../functions/capitalize.dart';
import '../../widgets/information_list_tile.dart';
import '../../functions/request.dart';
import 'functions/get_homework.dart';
import 'functions/open_add_homework_page.dart';
import 'dart:convert';

class DetailsPage extends StatefulWidget {

  final Map homeworkItem;
  final String displayDate;
  final String dateString;
  final String uniqueId;

  DetailsPage(this.homeworkItem, this.displayDate, this.dateString, this.uniqueId);

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
      if(widget.homeworkItem['is_custom'] == true){
        return Theme.of(context).accentColor;
      }
      if(widget.homeworkItem['test'] == 'ja'){
        return Colors.redAccent;
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
                    capitalize(widget.displayDate) + (widget.homeworkItem['teacher'] != "" ? " - "  + capitalize(widget.homeworkItem['teacher']) : ""),
                    style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),
                  ),
                ],
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: bgColor),
                child: BottomInformationCard(widget.homeworkItem, bgColor, widget.dateString)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomInformationCard extends StatefulWidget {

  final Map homeworkItem;
  final Color bgColor;
  final String dateString;

  BottomInformationCard(this.homeworkItem, this.bgColor, this.dateString);

  @override
  _BottomInformationCardState createState() => _BottomInformationCardState();
}

class _BottomInformationCardState extends State<BottomInformationCard> {
  bool isLoading = false;
  bool canDelete = false;
  bool canEdit = false;
  bool isCustom = false;

  void deleteItem(context) async {
    setState(() {
      isLoading = true;
    });

    try{
      String rawHomeworkAfterAdd = await getDataFromAPI('/homework/delete', {'id': widget.homeworkItem['id']});
      loadedHomework = json.decode(rawHomeworkAfterAdd);
      Navigator.pop(context);
    }catch(e){
      setState(() {
        isLoading = false;
      });
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text("Er is wat fout gegaan bij het verwijderen van het huiswerk. Geef dit asjeblieft aan via de Feedback pagina."),
      ));
    }
  }

  void editItem(context) async {
    widget.homeworkItem['date'] = widget.dateString;
    openAddHomeworkPage(context, widget.homeworkItem, "Wijzig huiswerk", true);
  }

  void toggleItemDone(context) async {
    setState(() {
      isLoading = true;
    });
    try{
      String rawHomeworkAfterAdd = await postDataToAPI('/homework/done', {'id': widget.homeworkItem['id'].toString(), 'done': (!(widget.homeworkItem['homework_made'] == true)).toString()});
      loadedHomework = json.decode(rawHomeworkAfterAdd);
      Navigator.pop(context);
    }catch(e){
      print(e);
      setState(() {
        isLoading = false;
      });
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text("Er is wat fout gegaan bij het updaten van het huiswerk. Geef dit asjeblieft aan via de Feedback pagina."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {

    if(widget.homeworkItem['is_custom'] == true && widget.homeworkItem['can_delete'] == true){
      canDelete = true;
    }
    if(widget.homeworkItem['is_custom'] == true && widget.homeworkItem['can_edit'] == true){
      canEdit = true;
    }
    if(widget.homeworkItem['is_custom'] == true){
      isCustom = true;
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
            padding: EdgeInsets.only(top: 8.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: AnimatedCrossFade(firstChild: Container(), secondChild: LinearProgressIndicator(), duration: Duration(milliseconds: 100), crossFadeState: isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst),
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0), child: 
                  Text(widget.homeworkItem['homework'], style: Theme.of(context).textTheme.body1.copyWith(fontSize: 14.5),)),
              Padding(padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0), child: Divider()),
              isCustom != true ? InformationListTile(leadingText: 'Toets?', titleText: capitalize(widget.homeworkItem['test'])) : Container(),
              InformationListTile(leadingText: 'Gemaakt?', titleText: widget.homeworkItem['homework_made'] == true ? 'Ja' : 'Nee'),
              isCustom == true ?  InformationListTile(leadingText: 'Zichtbaar voor?', titleText: widget.homeworkItem['is_for_group'] == true ? 'De hele klas (' + widget.homeworkItem['group'] + ')' : 'Alleen jij') : Container(),
              isCustom == true ? Padding(padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0), child: Divider()) : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  isCustom ? RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    color: widget.homeworkItem['homework_made'] == true ? Colors.grey : Colors.green,
                    child: Icon(Icons.done, color: Colors.white), 
                    onPressed: isLoading ? null : () => {toggleItemDone(context)},
                  ) : null,
                  canEdit ? Hero(tag: "_AddHomeWorkEditPageHero", child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    color: Colors.orangeAccent,
                    child: Icon(Icons.edit, color: Colors.white), 
                    onPressed: isLoading ? null : () => editItem(context),
                  )) : null,
                  canDelete ? RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white), 
                    onPressed: isLoading ? null : () => deleteItem(context),
                  ) : null
                ].where((Object o) => o != null).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
