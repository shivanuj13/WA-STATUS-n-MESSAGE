import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late bool isDark;
  late SharedPreferences _sharedPreferences;

  ThemeProvider._();
  static final ThemeProvider instance = ThemeProvider._();

  initSharedPref() async {
    _sharedPreferences= await SharedPreferences.getInstance();
  }

  Future<void> changeTheme() async {
    isDark = !isDark;
    await _sharedPreferences.setBool('isDark', isDark);
    notifyListeners();
  }

  Future<bool> getTheme() async {
    this.isDark=false;
 
    bool? isDark = _sharedPreferences.getBool('isDark');
    if (isDark != null) {
      this.isDark = isDark;
      notifyListeners();
      return isDark;
    }
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    isDark = brightness == Brightness.dark;
    await _sharedPreferences.setBool('isDark', isDark);
    notifyListeners();
    return isDark;
  }
}
