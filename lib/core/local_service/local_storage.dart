import 'package:hive_flutter/hive_flutter.dart';
import 'package:saudi_calender_task/core/enums/constants_enums.dart';

class LocalStorage {
  LocalStorage._internal();
  static final LocalStorage _singleton = LocalStorage._internal();
  static LocalStorage get instance => _singleton;

  late Box box;

  Future<void> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox(ConstantsEnums.mainHiveBox.name);
  }

  Future<void> put(dynamic key, dynamic value) async {
    await box.put(key, value);
  }

  dynamic get(dynamic key, {dynamic defaultValue}) {
    final data = box.get(
      key,
      defaultValue: defaultValue,
    );
    return data;
  }

  Future<void> remove(dynamic key) async {
    await box.delete(key);
  }

  Future<void> clearBox() async {
    await box.clear();
  }
}