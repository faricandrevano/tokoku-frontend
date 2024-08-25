import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/auth/auth.dart';

class LogoutUseCase implements UseCaseFuture<Failure, bool, NoParams> {
  LogoutUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  FutureOr<Either<Failure, bool>> call(NoParams params) async {
    return authRepository.logout();
  }
}
