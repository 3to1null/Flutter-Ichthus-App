///Checks if a user might be searched for
bool foundQueryResult(userData, String query){
  if(userData["userCode"].toString().contains(query)){return true;}
  if(userData["name"].toLowerCase().contains(query.toLowerCase())){return true;}
  return false;
}