import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

class GetLanguageSettingUseCase
    implements UseCaseFuture<Failure, Language, NoParams> {
  GetLanguageSettingUseCase(this.repository);
  final SettingsRepository repository;

  @override
  FutureOr<Either<Failure, Language>> call(NoParams params) {
    return repository.getLanguageSetting();
  }
}
