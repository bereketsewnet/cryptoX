import 'package:dio/dio.dart';

import '../consts.dart';

class HTTPService {
  final Dio dio = Dio();

  HTTPService(){
    configureDio();
  }

  void configureDio() {
    dio.options = BaseOptions(
      baseUrl: 'https://api.cryptorank.io/v1/',
      queryParameters: {
        'api_key': CRYPTO_RANK_API_KEY,
      }
    );
  }

  Future<dynamic> get(String path) async{
    try{
      Response response = await dio.get(path);
      return response.data;
    }catch (e){
      print(e);
    }
  }
}