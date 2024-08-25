import 'package:shamo_mobile/core/core.dart';

class CacheFailure extends Failure {
  const CacheFailure({required String message, Object? code})
      : super(message: message, code: code);
}
