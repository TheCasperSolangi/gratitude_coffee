import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferencesHelper? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPreferencesHelper?> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesHelper();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  // Getters
  String? get customerId => _preferences?.getString('customer_id');
  String? get address1 => _preferences?.getString('address1');
  String? get address2 => _preferences?.getString('address2');
  String? get city => _preferences?.getString('city');
  String? get state => _preferences?.getString('state');
  String? get postalCode => _preferences?.getString('postalCode');
  String? get email => _preferences?.getString('email');

  // Setters
  Future<void> setCustomerId(String value) async =>
      await _preferences?.setString('customer_id', value);

  Future<void> setAddress1(String value) async =>
      await _preferences?.setString('address1', value);

  Future<void> setAddress2(String value) async =>
      await _preferences?.setString('address2', value);

  Future<void> setCity(String value) async =>
      await _preferences?.setString('city', value);

  Future<void> setState(String value) async =>
      await _preferences?.setString('state', value);

  Future<void> setPostalCode(String value) async =>
      await _preferences?.setString('postalCode', value);

  Future<void> setEmail(String value) async =>
      await _preferences?.setString('email', value);
}