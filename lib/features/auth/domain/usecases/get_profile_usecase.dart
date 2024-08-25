import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/auth/auth.dart';

class GetProfileUseCase implements UseCaseFuture<Failure, User, NoParams> {
  GetProfileUseCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  FutureOr<Either<Failure, User>> call(NoParams params) async {
    return authRepository.getProfile();
  }
}
