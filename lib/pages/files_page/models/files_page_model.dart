class FilesPageModel {
  static final FilesPageModel _filesPageModel = new FilesPageModel._internal();

  factory FilesPageModel() {
    return _filesPageModel;
  }

  FilesPageModel._internal();

  Map<String, String> cookies;

}