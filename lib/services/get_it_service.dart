import 'package:get_it/get_it.dart';
import 'package:saudi_calender_task/services/dio_service.dart';

import '../core/repos/event_repo_impl.dart';
import '../remote_service/event_service.dart';
import 'get_data_service.dart';

final GetIt getIt = GetIt.instance;

void getItSetup() async {
  getIt.registerSingleton<DioService>(
    DioService(),
  );
  getIt.registerSingleton<GetDataService>(GetDataService());
  getIt.registerSingleton<EventRepoImpl>(EventRepoImpl());
  getIt.registerSingleton<EventRiverpod>(EventRiverpod(
    getIt.get<EventRepoImpl>(),
  ));
}
