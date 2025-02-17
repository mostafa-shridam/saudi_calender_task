import 'package:get_it/get_it.dart';
import 'package:saudi_calender_task/services/dio_service.dart';

import '../core/repos/repo_impl.dart';
import '../providers/event_provider.dart';
import 'get_data_service.dart';

final GetIt getIt = GetIt.instance;

void getItSetup() async {
  getIt.registerSingleton<DioService>(
    DioService(),
  );
  getIt.registerSingleton<GetDataService>(GetDataService());
  getIt.registerSingleton<RepoImpl>(RepoImpl());
  getIt.registerSingleton<EventRemoteService>(EventRemoteService(
    getIt.get<RepoImpl>(),
  ));
}
