import 'package:get_it/get_it.dart';
import 'package:blog_post/core/app/data/datasources/api_datasource.dart';

final coreInjection = GetIt.instance;

void coreInit() {
  // Datasources
  coreInjection.registerLazySingleton<ApiDataSource>(
    () => ApiDataSourceImpl(),
  );
}
