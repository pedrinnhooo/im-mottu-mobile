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
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.red.shade900,
          title: const Text(
            'Personagens da Marvel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 230,
                mainAxisExtent: 210,
                crossAxisSpacing: 2,
              ),
              itemCount: _data.length,
              itemBuilder: (BuildContext context, int index) {
                final character = _data[index];
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 10, top: 20, right: 10, bottom: 10),
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.black87,
                                Colors.red.shade900,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(2, 2), //
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: ClipOval(
                                  child: Material(
                                    child: Image.network(
                                        character['thumbnail']['path'] +
                                            '.' +
                                            character['thumbnail']['extension'],
                                        width: 95,
                                        height: 80,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 14, left: 10),
                                  child: Center(
                                    child: Text(
                                      character['name'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                );
              }),
        ));
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
