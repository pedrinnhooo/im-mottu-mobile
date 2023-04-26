import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MarvelScreen extends StatefulWidget {
  const MarvelScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MarvelScreenState createState() => _MarvelScreenState();
}

class _MarvelScreenState extends State<MarvelScreen> {
  final publicKey = '5a174474ee6fd07dc7a6a444ba42798c';
  final privateKey = '338d08dc154d763aaceb9446d5d3fb2f1462ebc0';
  final ts = DateTime.now().millisecondsSinceEpoch.toString();
  late String _hash;

  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    _hash = generateMd5(ts + privateKey + publicKey);
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens da Marvel'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          final character = _data[index];
          return ListTile(
            leading: Image.network(character['thumbnail']['path'] +
                '.' +
                character['thumbnail']['extension']),
            title: Text(character['name']),
            subtitle: Text(character['description']),
          );
        },
      ),
    );
  }

  Future<void> _getData() async {
    final url =
        'https://gateway.marvel.com/v1/public/characters?ts=$ts&apikey=$publicKey&hash=$_hash';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    setState(() {
      _data = data['data']['results'];
    });
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
