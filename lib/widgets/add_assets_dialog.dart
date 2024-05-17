import 'package:cripto_x/models/api_response.dart';
import 'package:cripto_x/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class AddAssetDialogController extends GetxController {
  RxBool loading = false.obs;
  RxList<String> assets = <String>[].obs;
  RxString selectedAsset = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _getAssets();
  }

  Future<void> _getAssets() async {
    loading.value = true;
    HTTPService httpService = Get.find();
    var responseData = await httpService.get('currencies');
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseData);
    currenciesListAPIResponse.data?.forEach((coin) {
      assets.add(
        coin.name!,
      );
    });
    selectedAsset.value = assets.first;
    loading.value = false;
  }
}

class AddAssetDialog extends StatelessWidget {
  final controller = Get.put(
    AddAssetDialogController(),
  );

  AddAssetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Material(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.40,
            width: MediaQuery.sizeOf(context).width * 0.80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: _buildUI(context),
          ),
        ),
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    if (controller.loading.isTrue) {
      return const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Column(
        children: [
          DropdownButton(
              value: controller.selectedAsset.value,
              items: controller.assets
                  .map(
                    (assets) => DropdownMenuItem(
                      value: assets,
                      child: Text(assets),
                    ),
                  )
                  .toList(),
              onChanged: (value) {})
        ],
      );
    }
  }
}
