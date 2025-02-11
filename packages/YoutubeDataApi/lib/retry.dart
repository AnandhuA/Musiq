import 'dart:async';
import 'dart:developer';

/// Run the [function] each time an exception is thrown until the retryCount
/// is 0.
Future<T> retry<T>(FutureOr<T> Function() function) async {
  // ignore: literal_only_boolean_expressions
  while (true) {
    try {
      return await function();
      // ignore: avoid_catches_without_on_clauses
    } on Exception {
      log("---------------------errorr-----------------");
    }
  }
}
