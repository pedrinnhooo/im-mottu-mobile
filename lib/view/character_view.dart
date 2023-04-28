import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/character_controller.dart';

class MarvelScreen extends StatefulWidget {
  const MarvelScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MarvelScreenState createState() => _MarvelScreenState();
}

class _MarvelScreenState extends State<MarvelScreen> {
  final MarvelController marvelController = Get.put(MarvelController());

  String searchText = '';
  final pageController = PageController();
  int currentPage = 0;
  int itemsPerPage = 10;

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
        actions: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.globe,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {})),
        ],
      ),
      body: Obx(() => SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24, left: 24, right: 24, bottom: 8),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                        hintText: 'Pesquisar personagens',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 1,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 0.5,
                            )),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 230,
                        mainAxisExtent: 215,
                        crossAxisSpacing: 2,
                      ),
                      itemCount: marvelController.data
                          .where((character) => character['name']
                              .toLowerCase()
                              .contains(searchText.toLowerCase()))
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        final character = marvelController.data
                            .where((character) => character['name']
                                .toLowerCase()
                                .contains(searchText.toLowerCase()))
                            .toList()[index];
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    useRootNavigator: true,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            tileMode: TileMode.clamp,
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Colors.grey.shade900,
                                              Colors.black,
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: Image.network(
                                                  character['thumbnail']
                                                          ['path'] +
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    "Name: ",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    character['name'],
                                                    style:
                                                        GoogleFonts.luckiestGuy(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.redAccent,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            Row(
                                              children: const [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    "Description: ",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 300,
                                                    child: Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          character[
                                                              'description'],
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 35,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Row(
                                                children: const [
                                                  Text(
                                                    "Related: ",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20, left: 20, right: 20),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 210,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.redAccent,
                                                      style: BorderStyle.solid,
                                                      width: 0.5)),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Wrap(
                                                    spacing: 8,
                                                    children: (character[
                                                                    'comics']
                                                                ['items']
                                                            as List<dynamic>)
                                                        .map<Chip>(
                                                            (comic) => Chip(
                                                                  label: Text(
                                                                      comic[
                                                                          'name']),
                                                                ))
                                                        .toList(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                )),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                onTap: () => Get.back(),
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(30),
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red.shade900,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 3,
                                        spreadRadius: 3,
                                        offset: Offset(1, 1), //
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: ClipOval(
                                          child: Material(
                                              child: Image.network(
                                                  character['thumbnail']
                                                          ['path'] +
                                                      '.' +
                                                      character['thumbnail']
                                                          ['extension'],
                                                  width: 95,
                                                  height: 80,
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 14, left: 8, right: 8),
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
                )
              ],
            ),
          )),
    );
  }
}
