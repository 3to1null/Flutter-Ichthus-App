import 'dart:async';

class CijferDataModel {
  static final CijferDataModel _cijferDataModel =
      new CijferDataModel._internal();

  factory CijferDataModel() {
    return _cijferDataModel;
  }

  CijferDataModel._internal();

  List<int> periodsLoadedThisRun;

  List<Map<String, dynamic>> cijfersPeriod1;
  List<Map<String, dynamic>> cijfersPeriod2;
  List<Map<String, dynamic>> cijfersPeriod3;
  List<Map<String, dynamic>> cijfersPeriod4;

  void setCijfersForPeriodInRam(int period, List<Map<String, dynamic>> cijfers){
    assert(1 <= period && period <= 4);
    switch (period) {
      case 1: cijfersPeriod1 = cijfers; return;
      case 2: cijfersPeriod2 = cijfers; return;
      case 3: cijfersPeriod3 = cijfers; return;
      case 4: cijfersPeriod4 = cijfers; return;
      default: return;
    }
  }

  List<Map<String, dynamic>> getCijferForPeriodFromRam(int period){
    assert(1 <= period && period <= 4);
    switch (period) {
      case 1: return cijfersPeriod1;
      case 2: return cijfersPeriod2;
      case 3: return cijfersPeriod3;
      case 4: return cijfersPeriod4;
      default: return cijfersPeriod1;
    }
  }

  StreamController<List<Map<String, dynamic>>> streamControllerCijfersPeriod1;
  StreamController<List<Map<String, dynamic>>> streamControllerCijfersPeriod2;
  StreamController<List<Map<String, dynamic>>> streamControllerCijfersPeriod3;
  StreamController<List<Map<String, dynamic>>> streamControllerCijfersPeriod4;

  StreamController<List<Map<String, dynamic>>> getStreamController(int period){
    assert(1 <= period && period <= 4);
    switch (period) {
      case 1: return streamControllerCijfersPeriod1;
      case 2: return streamControllerCijfersPeriod2;
      case 3: return streamControllerCijfersPeriod3;
      case 4: return streamControllerCijfersPeriod4;
      default: return streamControllerCijfersPeriod1;
    }
  }

  void setStreamController(int period, StreamController<List<Map<String, dynamic>>> streamController){
    assert(1 <= period && period <= 4);
    switch (period) {
      case 1: streamControllerCijfersPeriod1 = streamController; return;
      case 2: streamControllerCijfersPeriod2 = streamController; return;
      case 3: streamControllerCijfersPeriod3 = streamController; return;
      case 4: streamControllerCijfersPeriod4 = streamController; return;
      default: return;
    }
  }

}
