import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel/controller/comic_controller.dart';


class ComicsView extends GetView<ComicsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: 170,
      color: Colors.transparent,
      child: Obx(() {
        if (controller.data.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                final comic = controller.data[index];
                return Column(
                  children: [
                    GestureDetector(
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
                                              comic['thumbnail']['path'] +
                                                  '.' +
                                                  comic['thumbnail']['extension'],
                                              width: 100,
                                              height: 100,
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
                                                          comic[
                                                                  'title'] ,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                                      textAlign: TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
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
                                                          comic[
                                                                  'description'] ,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontSize: 12,
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
                                              height: 35,
                                            ),
                                            ComicsView(),
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
                                                        BorderRadius.circular(20),
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
                      child:  Padding(
                      padding: const EdgeInsets.only(top: 0, left: 20),
                      child: ClipOval(
                        child: Material(
                          child: Image.network(
                              comic['thumbnail']['path'] +
                                  '.' +
                                  comic['thumbnail']['extension'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              });
        }
      }),
    );
  }
}
