import 'package:hadafo/controller/article.controller.dart';
import 'package:hadafo/controller/radio.controller.dart';
import 'package:hadafo/controller/tv.controller.dart';
import 'package:hadafo/controller/utils.controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {

  @override
    void dependencies() {
      Get.put(UtilsController(), permanent: true);
      Get.put(ArticleController(), permanent: true);
      Get.put(RadioController(), permanent: true);
      Get.put(TvController(), permanent: true);
    }
}