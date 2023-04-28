import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MarvelController extends GetxController {
  final String publicKey = '5a174474ee6fd07dc7a6a444ba42798c';
  final String privateKey = '338d08dc154d763aaceb9446d5d3fb2f1462ebc0';

  final String ts = DateTime.now().millisecondsSinceEpoch.toString();
  late String _hash;

  RxList<dynamic> data = RxList<dynamic>([]);

  @override
  void onInit() {
    super.onInit();
    _hash = generateMd5(ts + privateKey + publicKey);
    _getCachedData();
    _getData();
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  // armazena a resposta da api em cache
  Future<void> _getCachedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cachedData = prefs.getString('marvel_data') ?? '';
    if (cachedData.isNotEmpty) {
      List<dynamic> cachedList = jsonDecode(cachedData);
      data.assignAll(cachedList);
      print('Carregando dados do cache');
    }
  }

  // pega os dados da api
  Future<void> _getData() async {
    final url =
        'https://gateway.marvel.com/v1/public/characters?ts=$ts&apikey=$publicKey&hash=$_hash';
    final response = await http.get(Uri.parse(url));
    final responseData = jsonDecode(response.body);
    final results = responseData['data']['results'];
    data.assignAll(results);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('marvel_data', jsonEncode(results));
    if (data.isNotEmpty) {
      print('Carregando dados da API');
    }
  }

  // limpa o cache
  @override
  void onClose() {
    super.onClose();
    DefaultCacheManager().emptyCache();
  }
}
