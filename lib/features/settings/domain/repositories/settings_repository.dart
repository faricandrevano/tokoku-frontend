import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

abstract class SettingsRepository {
  Future<Either<Failure, Settings>> getSettings();

  Future<Either<Failure, bool>> saveSettings(Settings setting);

  Future<Either<Failure, AppTheme>> getThemeSetting();

  Future<Either<Failure, Language>> getLanguageSetting();

  Future<Either<Failure, bool>> saveThemeSetting(AppTheme theme);

  Future<Either<Failure, bool>> saveLanguageSetting(Language language);

  Future<Either<Failure, bool>> getOnboardingStatus();

  Future<Either<Failure, bool>> setDoneOnboarding();
}
