///Tries to convert the [value] to a Boolean. 
bool convertToBool(value, {bool defaultsTo: false}){
  if(value is bool){
    return value;
  }
  if(defaultsTo){
    if(value == "False" || value == "false"){
      return false;
    }
    return true;
  }else{
    if(value == "True" || value == "true"){
      return true;
    }
    return false;
  }
}