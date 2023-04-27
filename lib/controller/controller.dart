import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    _getData();
  }

  Future<void> _getData() async {
    final url =
        'https://gateway.marvel.com/v1/public/characters?ts=$ts&apikey=$publicKey&hash=$_hash';
    final response = await http.get(Uri.parse(url));
    final responseData = jsonDecode(response.body);
    final results = responseData['data']['results'];
    data.assignAll(results);
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
