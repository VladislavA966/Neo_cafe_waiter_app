import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:neo_cafe_24/core/services/dio_settings.dart';
import 'package:neo_cafe_24/features/auth/data/data_source/local_data_source/local_data_source.dart';
import 'package:neo_cafe_24/features/auth/data/data_source/remote_data_source/auth_remote_data.dart';
import 'package:neo_cafe_24/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:neo_cafe_24/features/auth/domain/use_case/auth_use_case.dart';
import 'package:neo_cafe_24/features/auth/domain/use_case/send_code_use_case.dart';
import 'package:neo_cafe_24/features/menu_screen/data/data_source/menu_remote_data_dource.dart';
import 'package:neo_cafe_24/features/menu_screen/data/repository_impl/category_repository_impl.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/use_cases/category_use_case.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/use_cases/menu_items_use_case.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/data/data_source/local/cart_local_data_source.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/data/model/cart_model/cart_model.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/data/repository_impl/cart_repository_impl.dart';
import 'package:neo_cafe_24/features/shopping_cart_screen.dart/domain/use_case/cart_use_case.dart';

final getIt = GetIt.instance;

void setUpDependency() {
  getIt.registerSingleton<AuthDataSource>(AuthDataSource());
  getIt.registerSingleton<DioSettings>(
    DioSettings(
      getIt<AuthDataSource>(),
    ),
  );
  authDependency();
  manuDependency();
  cartDependency();
}

//Auth
void authDependency() {
  getIt.registerSingleton<AuthRemote>(
    AuthRemote(
      getIt<DioSettings>().dio,
    ),
  );
  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      remote: getIt<AuthRemote>(),
      local: getIt<AuthDataSource>(),
    ),
  );
  getIt.registerSingleton<AuthUseCase>(
    AuthUseCase(
      repo: getIt<AuthRepoImpl>(),
    ),
  );
  getIt.registerSingleton<SendCodeUseCase>(
    SendCodeUseCase(
      repo: getIt<AuthRepoImpl>(),
    ),
  );
}

//Cart
void cartDependency() {
  getIt.registerSingleton<CartLocalDataSourceImpl>(CartLocalDataSourceImpl(
    getIt<Box<CartModel>>(),
  ));
  getIt.registerSingleton<CartRepositoryImpl>(CartRepositoryImpl(
    data: getIt<CartLocalDataSourceImpl>(),
  ));
  getIt.registerSingleton<CartUseCase>(
    CartUseCase(repo: getIt<CartRepositoryImpl>()),
  );
}

//Menu
void manuDependency() {
  getIt.registerSingleton<MenuRemoteImpl>(
    MenuRemoteImpl(
      dio: getIt<DioSettings>().dio,
      // local: getIt<BranchLocalData>(),
    ),
  );
  getIt.registerSingleton<MenuRepositoryImpl>(
    MenuRepositoryImpl(
      remote: getIt<MenuRemoteImpl>(),
    ),
  );
  getIt.registerSingleton<CategoryUseCase>(
    CategoryUseCase(
      repo: getIt<MenuRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton<AllItemsUseCase>(
    AllItemsUseCase(
      repo: getIt<MenuRepositoryImpl>(),
    ),
  );
}
