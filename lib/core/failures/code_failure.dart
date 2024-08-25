import 'package:shamo_mobile/core/core.dart';

class CodeFailure extends Failure {
  const CodeFailure({required String message, Object? code})
      : super(message: message, code: code);
}
