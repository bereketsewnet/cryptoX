import 'package:cripto_x/controller/assets_controller.dart';
import 'package:cripto_x/services/http_service.dart';
import 'package:get/get.dart';

Future<void> registerServices() async {
  Get.put(
    HTTPService(),
  );
}

Future<void> registerControllers() async {
  Get.put(
    AssetsController(),
  );
}

String getCryptoImageURL(String name) {
  return 'https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/128/${name.toLowerCase()}.png';
}
