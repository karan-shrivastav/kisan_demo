
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferenceHelper {

  // Write Data
  Future<bool> saveCustomerData(key,value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(key, value.toString());
  }
// Read Data
  Future<String?> getCustomerData(key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
  // clean data
  Future<void> clearCustomerData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
  Future<String?> loadData() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
    AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('farmerId');
  }
  Future<String?> getDataFromSharedPreference(data) async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
    AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData(data);
  }

}