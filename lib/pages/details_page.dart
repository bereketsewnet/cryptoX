import 'package:cripto_x/utils.dart';
import 'package:flutter/material.dart';

import '../models/coin_data.dart';

class DetailsPage extends StatelessWidget {
  final CoinData coin;

  const DetailsPage({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildUI(context),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        coin.name!,
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery
              .sizeOf(context)
              .width * 0.02,
        ),
        child: Column(
          children: [
            _assetPrice(context),
            _assetInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _assetPrice(BuildContext context) {
    return SizedBox(
      height: MediaQuery
          .sizeOf(context)
          .height * 0.10,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(
              getCryptoImageURL(coin.name!),
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '\$ ${coin.values?.uSD?.price?.toStringAsFixed(2)}\n',
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                TextSpan(
                  text: '${coin.values?.uSD?.percentChange24h?.toStringAsFixed(
                      2)} \%',
                  style: TextStyle(
                    fontSize: 15,
                    color: coin.values!.uSD!.percentChange24h! > 0 ? Colors
                        .green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _assetInfo(BuildContext context) {
    return Expanded(
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
          ),

        ));
  }
}
