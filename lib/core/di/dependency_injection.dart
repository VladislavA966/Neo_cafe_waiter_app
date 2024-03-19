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
import 'package:neo_cafe_24/features/new_order_screen/data/data_source/local/cart_local_data_source.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/data_source/remote/new_oreder_remote.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/data_source/remote/table_data_source.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/mapper/item_order_mapper.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/mapper/table_mapper.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/model/cart_model/cart_model.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/repository_impl/cart_repository_impl.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/repository_impl/order_repository_impl.dart';
import 'package:neo_cafe_24/features/new_order_screen/data/repository_impl/table_repository_impl.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/use_case/all_tables_use_case.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/use_case/cart_use_case.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/use_case/current_table_use_case.dart';
import 'package:neo_cafe_24/features/new_order_screen/domain/use_case/order_use_case.dart';
import 'package:neo_cafe_24/features/order_screen/data/data_source/order_list_remote.dart';
import 'package:neo_cafe_24/features/order_screen/data/mapper/to_entity_item_mapper.dart';
import 'package:neo_cafe_24/features/order_screen/data/mapper/to_entity_order_mapper.dart';
import 'package:neo_cafe_24/features/order_screen/data/mapper/to_entity_table_mapper.dart';
import 'package:neo_cafe_24/features/order_screen/data/repository_impl/orders_list_repo_impl.dart';
import 'package:neo_cafe_24/features/order_screen/domain/use_case/orders_list_use_case.dart';

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
  mappers();
  newOrderDependencies();
  tableDependencies();
  ordersList();
}

//Auth
void authDependency() {
  getIt.registerSingleton<AuthRemoteImpl>(
    AuthRemoteImpl(
      dio: getIt<DioSettings>().dio,
      local: getIt<AuthDataSource>(),
    ),
  );
  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      remote: getIt<AuthRemoteImpl>(),
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

//SendOrder
void newOrderDependencies() {
  getIt.registerSingleton<NewOrderRemoteImpl>(
    NewOrderRemoteImpl(
      dio: getIt<DioSettings>().dio,
    ),
  );
  getIt.registerSingleton<NewOrderRepositoryImpl>(
    NewOrderRepositoryImpl(
      orderRemote: getIt<NewOrderRemoteImpl>(),
      itemMapper: getIt<ItemOrderMapper>(),
      tableMapper: getIt<TableMapper>(),
      cartLocal: getIt<CartLocalDataSourceImpl>(),
      authLocal: getIt<AuthDataSource>(),
    ),
  );
  getIt.registerSingleton<NewOrderUseCase>(
    NewOrderUseCase(
      repo: getIt<NewOrderRepositoryImpl>(),
    ),
  );
}

//Table
void tableDependencies() {
  getIt.registerSingleton<TableRemoteImpl>(
    TableRemoteImpl(
      local: getIt<AuthDataSource>(),
      dio: getIt<DioSettings>().dio,
    ),
  );
  getIt.registerSingleton<TableRepositoryImpl>(
    TableRepositoryImpl(
      remote: getIt<TableRemoteImpl>(),
    ),
  );
  getIt.registerSingleton<AllTableUseCase>(
    AllTableUseCase(
      repo: getIt<TableRepositoryImpl>(),
    ),
  );
  getIt.registerSingleton<CurrentTableUseCase>(
    CurrentTableUseCase(
      repo: getIt<TableRepositoryImpl>(),
    ),
  );
}

//Get orders list
void ordersList() {
  getIt.registerSingleton<OrdersListRomoteImpl>(
    OrdersListRomoteImpl(
      dio: getIt<DioSettings>().dio,
    ),
  );
  getIt.registerSingleton<OrdersListRepoImpl>(
    OrdersListRepoImpl(
      remote: getIt<OrdersListRomoteImpl>(),
      orderMapper: getIt<OrderToEntityMapper>(),
    ),
  );
  getIt.registerSingleton<OrdersListUseCase>(
    OrdersListUseCase(
      repo: getIt<OrdersListRepoImpl>(),
    ),
  );
}

//Mapper
void mappers() {
  getIt.registerSingleton<TableMapper>(
    TableMapper(),
  );
  getIt.registerSingleton<ItemOrderMapper>(
    ItemOrderMapper(),
  );
  getIt.registerSingleton<ToEntityItemMapper>(
    ToEntityItemMapper(),
  );
  getIt.registerSingleton<ToEntityTableMapper>(
    ToEntityTableMapper(),
  );
  getIt.registerSingleton<OrderToEntityMapper>(
    OrderToEntityMapper(
      itemMapper: getIt<ToEntityItemMapper>(),
      tableMapper: getIt<ToEntityTableMapper>(),
    ),
  );
}
