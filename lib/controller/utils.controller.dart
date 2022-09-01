import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hadafo/tools/constants.dart';

class UtilsController extends GetxController {
  var status = "off".obs;
  var tabIndex = 0.obs;
  var nextIndex = 0.obs;
  var isPlaying = true.obs;
  var showBottomBar = true.obs;
  RxBool isDarkMode = false.obs;
  var currentLink = "".obs;

  @override
  void onInit() {
    super.onInit();
    updateChangeTheme(false,1);
  }

  updateTabIndex(index) {
    if(tabIndex.value != index){
      nextIndex.value = tabIndex.value;
      tabIndex.value = index;
    }else {
      tabIndex.value = index;
    }
  } 
  updateStatus(val) => status.value = val;
  updateCurrentLink(val) => currentLink.value = val;
  playPause(val) => isPlaying.value = val;
  updateShowBottomBar(val) => showBottomBar.value = val;
  updateChangeTheme(bool val,[init = 0]) async {
    final box = GetStorage();
    if(init == 1){
      var isDarkMode_ = box.read(MyCst.darkMode);
      if(isDarkMode_ != null) {
        isDarkMode.value = isDarkMode_;
      } else {
        isDarkMode.value = Get.isDarkMode;
      }

    }
    else {
      await box.write(MyCst.darkMode, val);
      isDarkMode.value = val;

    }
  }
}
