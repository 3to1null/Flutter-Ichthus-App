class FilesPageModel {
  static final FilesPageModel _filesPageModel = new FilesPageModel._internal();

  factory FilesPageModel() {
    return _filesPageModel;
  }

  FilesPageModel._internal();

  Map<String, String> cookies;

  String authToken;

  String get cookieString {
    if(this.cookies == null){
      return null;
    }
    String tempCookieString = "";
    this.cookies.forEach((cookie, value){
      tempCookieString += "$cookie=$value; ";
    });
    return tempCookieString;
  }

}