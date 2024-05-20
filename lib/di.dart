import 'package:fuel_delivery_app_user/features/auth/data/datasources/auth_datasorce.dart';
import 'package:get_it/get_it.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/domain/repositories/auth_rempsitory.dart';
import 'features/auth/domain/usecases/auth_usecase.dart';

final locator = GetIt.instance;

void setUP() {
  locator.registerLazySingleton<SignUpUsecaseImpl>(
      () => SignUpUsecaseImpl(userRepository: locator()));
  locator.registerLazySingleton<SaveUserDataUsecaseImpl>(
      () => SaveUserDataUsecaseImpl(userRepository: locator()));
  locator.registerLazySingleton<CheckEmailVerifiedUsecaseImpl>(
      () => CheckEmailVerifiedUsecaseImpl(authRepository: locator()));
  locator.registerLazySingleton<CheckSignInUsecaseImpl>(
      () => CheckSignInUsecaseImpl(authRepository: locator()));

  locator.registerLazySingleton<SingOutUsecaseImpl>(
      () => SingOutUsecaseImpl(authRepository: locator()));
  locator.registerLazySingleton<SignInUsecaseImpl>(
      () => SignInUsecaseImpl(authRepository: locator()));
  locator.registerLazySingleton<SendVerificationEmaileUsecaseImpl>(
      () => SendVerificationEmaileUsecaseImpl(authRepository: locator()));
  locator.registerLazySingleton<SignInWithGoogleUsecaseImpl>(
      () => SignInWithGoogleUsecaseImpl(authRepository: locator()));
  locator.registerLazySingleton<AuthDataSorce>(() => AuthDataSorce());
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositryImpl(authDataSorce: locator()));
}
