import 'package:cripto_x/services/http_service.dart';
import 'package:get/get.dart';

Future<void> registerServices() async {
  Get.put(
    HTTPService(),
  );
}
