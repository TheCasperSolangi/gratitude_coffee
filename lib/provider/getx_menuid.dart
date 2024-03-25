import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MenuIdentityController extends GetxController {
  late RxInt _menuId = 0.obs;

  void setMenuId(int id) {
    _menuId.value = id;
  }

  int get menuId => _menuId.value;
}
