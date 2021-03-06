import 'is_in_debug_mode.dart';
import 'package:sentry/sentry.dart';
import 'dart:async';
import '../models/user_model.dart';

UserModel userModel = UserModel();
SentryClient _sentry = SentryClient(dsn: "https://33d6b5b492914f83a052e5840ab6f35e@sentry.io/1302181");

/// Prints or reports the errors to Sentry.
Future<Null> reportError(dynamic error, dynamic stackTrace) async {
  print("Reported error $error to Sentry");
  _sentry.userContext = User(id: userModel.userCode ?? "not_logged_in", username: userModel.userName);
  // Print the exception to the console 
  print('Caught error: $error');
  if (isInDebugMode) {
    // Print the full stacktrace in debug mode
    print(stackTrace);
    return;
  } else {
    // Send the Exception and Stacktrace to Sentry in Production mode
    _sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    ); 
  }
}