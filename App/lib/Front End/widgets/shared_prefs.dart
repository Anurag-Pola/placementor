import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkIfAppLoadedFirstTime() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return !(prefs.containsKey("LoadedFirstTime"));
}

Future<void> setAppLoadedFirstTimeToTrue() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool("LoadedFirstTime", true);
}
