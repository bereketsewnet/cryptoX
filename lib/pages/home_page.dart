import 'package:cripto_x/models/tracked_asset.dart';
import 'package:cripto_x/pages/details_page.dart';
import 'package:cripto_x/utils.dart';
import 'package:cripto_x/widgets/add_assets_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/assets_controller.dart';

class HomePage extends StatelessWidget {
  AssetsController assetsController = Get.find();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(context),
      body: _buildUI(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const CircleAvatar(
        backgroundImage: NetworkImage(
          'https://i.pravatar.cc/150?img=3',
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.dialog(AddAssetDialog());
          },
          icon: const Icon(Icons.add),
        )
      ],
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Column(
          children: [
            _portfolioValue(context),
            _tracedAssetsList(context),
          ],
        ),
      ),
    );
  }

  Widget _portfolioValue(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.03,
      ),
      child: Center(
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              const TextSpan(
                  text: '\$',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
              TextSpan(
                  text:
                      '${assetsController.getPortfolioValue().toStringAsFixed(2)}\n',
                  style: const TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w500,
                  )),
              const TextSpan(
                text: 'Portfolio value',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _tracedAssetsList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
            child: const Text(
              'Portfolio',
              style: TextStyle(
                fontSize: 10,
                color: Colors.black38,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.65,
            width: MediaQuery.sizeOf(context).width,
            child: ListView.builder(
              itemCount: assetsController.trackedAssets.length,
              itemBuilder: (context, index) {
                TrackedAsset trackedAsset =
                    assetsController.trackedAssets[index];
                return ListTile(
                  onTap: () {
                    Get.to(() {
                      return DetailsPage(
                          coin: assetsController
                              .getCoinData(trackedAsset.name!)!);
                    });
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        NetworkImage(getCryptoImageURL(trackedAsset.name!)),
                  ),
                  title: Text(
                    trackedAsset.name!,
                  ),
                  subtitle: Text(
                      'USD: ${assetsController.getAssetPrice(trackedAsset.name!).toStringAsFixed(2)}'),
                  trailing: Text(
                    trackedAsset.amount.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
