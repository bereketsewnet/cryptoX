import 'package:cripto_x/models/api_response.dart';
import 'package:cripto_x/models/coin_data.dart';
import 'package:cripto_x/models/tracked_asset.dart';
import 'package:cripto_x/services/http_service.dart';
import 'package:get/get.dart';

class AssetsController extends GetxController {
  RxList<CoinData> coinData = <CoinData>[].obs;
  RxBool loading = false.obs;
  RxList<TrackedAsset> trackedAssets = <TrackedAsset>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getAssets();
   // _loadTrackedAssetsFromStorage();
  }

  Future<void> _getAssets() async {
    loading.value = true;
    HTTPService httpService = Get.find();
    var responseData = await httpService.get("currencies");
    CurrenciesListAPIResponse currenciesListAPIResponse =
    CurrenciesListAPIResponse.fromJson(
      responseData,
    );
    coinData.value = currenciesListAPIResponse.data ?? [];
    loading.value = false;
  }

  void addTrackedAsset(String name, double amount) async {
    trackedAssets.add(
      TrackedAsset(
        name: name,
        amount: amount,
      ),
    );
    // List<String> data =
    // trackedAssets.map((asset) => jsonEncode(asset)).toList();
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setStringList(
    //   "tracked_assets",
    //   data,
    // );
  }

  // void _loadTrackedAssetsFromStorage() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? data = prefs.getStringList("tracked_assets");
  //   if (data != null) {
  //     trackedAssets.value = data
  //         .map(
  //           (e) => TrackedAsset.fromJson(
  //         jsonDecode(e),
  //       ),
  //     )
  //         .toList();
  //   }
  // }

  double getPortfolioValue() {
    if (coinData.isEmpty) {
      return 0;
    }
    if (trackedAssets.isEmpty) {
      return 0;
    }
    double value = 0;
    for (TrackedAsset asset in trackedAssets) {
      // increase the value by using traced assets or my crypto
      value += getAssetPrice(asset.name!) * asset.amount!;
    }
    return value;
  }

  double getAssetPrice(String name) {
    CoinData? data = getCoinData(name);
    // get the price and change in to double
    return data?.values?.uSD?.price?.toDouble() ?? 0;
  }

  // get coin by using name
  CoinData? getCoinData(String name) {
    return coinData.firstWhereOrNull((e) => e.name == name);
  }
}
