//set up deppendencies using get it
import 'package:fuel_delivery_app_user/interface/repository/auth_repo.dart';
import 'package:fuel_delivery_app_user/repository/auth_repository.dart';
import 'package:fuel_delivery_app_user/repository/service_repo.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setUp() async {
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(),
  );
  getIt.registerLazySingleton<ServicesRepo>(
    () => ServicesRepo(),
  );
}
