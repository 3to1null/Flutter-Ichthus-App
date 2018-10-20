class CijferDataModel {
  static final CijferDataModel _cijferDataModel =
      new CijferDataModel._internal();

  factory CijferDataModel() {
    return _cijferDataModel;
  }

  CijferDataModel._internal();

  List<int> periodsLoadedThisRun;
}
