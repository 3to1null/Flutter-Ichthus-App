bool convertToBool(value, {bool defaultTo: false}){
  if(value is bool){
    return value;
  }
  if(defaultTo){
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