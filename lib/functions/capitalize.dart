String capitalize(String s) {
  if(s == ""){return s;}
  if(s == null){return "";}
  return s[0].toUpperCase() + s.substring(1);
}
