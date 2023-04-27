import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

import '../controller/controller.dart';


class MarvelScreen extends StatefulWidget {
  const MarvelScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MarvelScreenState createState() => _MarvelScreenState();
}

class _MarvelScreenState extends State<MarvelScreen>  with WidgetsBindingObserver{
  final MarvelController marvelController = Get.put(MarvelController());

   @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //verifica state ciclo
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      clearCache();
    }
  }

  // limpa o cache
  Future<void> clearCache() async {
    final directory = await getTemporaryDirectory();
    if (directory.existsSync()) {
      directory.deleteSync(recursive: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset(
            "assets/marvelLogo.png",
            width: 90,
          ),
          centerTitle: true,
        ),
      body: Obx(() => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 230,
                mainAxisExtent: 215,
                crossAxisSpacing: 2,
              ),
              itemCount: marvelController.data.length,
              itemBuilder: (BuildContext context, int index) {
                final character = marvelController.data[index];
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    tileMode: TileMode.clamp,
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.red.shade900,
                                      Colors.black,
                                      Colors.black,
                                      Colors.red.shade900,
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Image.network(
                                            character['thumbnail']['path'] +
                                                '.' +
                                                character['thumbnail']
                                                    ['extension'],
                                            width: 95,
                                            height: 80,
                                            fit: BoxFit.cover),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Name: ",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            character['name'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            "Description: ",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 300,
                                              child: Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.start,
                                                children: [
                                                  Text(
                                                    character['description'],
                                                    style: const TextStyle(
                                                        color: Colors.redAccent,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 15,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 10, top: 20, right: 10, bottom: 10),
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              tileMode: TileMode.clamp,
                              colors: [
                                Colors.red.shade900,
                                Colors.black87,
                                Colors.black87,
                                Colors.red.shade900,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
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
                                      style: GoogleFonts.marvel(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        
                                      ),
                                      textAlign: TextAlign.center,
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
        )),
    );
  }
}
