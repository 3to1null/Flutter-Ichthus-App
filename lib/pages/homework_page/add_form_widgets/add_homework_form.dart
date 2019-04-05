import 'package:flutter/material.dart';
import 'dart:convert';

import 'textinput_vak.dart';
import 'textinput_desc.dart';
import 'dateinput_date.dart';
import 'checkbox_whole_class.dart';

import 'form_data.dart';
import '../../../functions/request.dart';
import '../functions/get_homework.dart';

class AddHomeworkForm extends StatefulWidget {
  @override
  _AddHomeworkFormState createState() => _AddHomeworkFormState();
}

class _AddHomeworkFormState extends State<AddHomeworkForm> {

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  bool formIsValid(context){
    Scaffold.of(context).removeCurrentSnackBar();
    if(formData['subject'].length < 2){
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text("Vaknaam moet minimaal 2 tekens lang zijn."),
      ));
      return false;
    }
    if(formData['date'].length != 10){
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text("Selecteer een datum."),
      ));
      return false;
    }
    if(formData['homework'].length == 0){
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text("Vul huiswerk in."),
      ));
      return false;
    }
    if(formData['homework'].length < 3){
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text("Geef een duidelijkere beschrijving van het huiswerk."),
      ));
      return false;
    }

    return true;
  }

  void saveNewItem(context) async{
    setState(() {
      isLoading = true;
    });

    try{
      String rawHomeworkAfterAdd = await postDataToAPI('/homework/add', formData);
      loadedHomework = json.decode(rawHomeworkAfterAdd);
      Navigator.pop(context);
    }catch(e){
      setState(() {
        isLoading = false;
      });
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text("Er is wat fout gegaan bij het toevoegen van het huiswerk. Geef dit asjeblieft aan via de Feedback pagina."),
      ));
    }
  }

  void validateAndSave(context){
    FocusScope.of(context).requestFocus(FocusNode());
    if(formIsValid(context)){
      saveNewItem(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
        children: <Widget>[
          isLoading ? LinearProgressIndicator() : Container(),
          VakTextInput(),
          Container(height: 8.0),
          HomeworkDateInput(),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0), child: Divider()),
          DescTextInput(),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0), child: Divider()),
          CheckBoxWholeClassHomework(),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0), child: Divider()),
          OutlineButton(
            highlightedBorderColor: Colors.transparent,
            child: Text('Opslaan'), 
            onPressed: isLoading ? null : () => validateAndSave(context),
          )
        ],
      ),
    );
  }
}