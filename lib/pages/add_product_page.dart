import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/api_service.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() =>
      _AddProductPageState();
}

class _AddProductPageState
    extends State<AddProductPage> {
  final TextEditingController
      nameController =
      TextEditingController();

  final TextEditingController
      priceController =
      TextEditingController();

  final TextEditingController
      descriptionController =
      TextEditingController();

  bool isLoading = false;

  Future<void> saveProduct() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController
            .text
            .isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Semua field wajib diisi',
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    ProductModel product =
        ProductModel(
      id: 0,
      name: nameController.text,
      price: int.parse(
        priceController.text,
      ),
      description:
          descriptionController.text,
    );

    bool success =
        await ApiService.addProduct(
      product,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          backgroundColor:
              Colors.green,
          content: Text(
            'Produk berhasil ditambahkan',
          ),
        ),
      );

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Gagal menambahkan produk',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xff0D0D0D),

      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Tambah Produk',
          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            Container(
              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color:
                    const Color(0xff161616),
                borderRadius:
                    BorderRadius.circular(
                  25,
                ),
                border: Border.all(
                  color:
                      Colors.redAccent,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors
                        .redAccent
                        .withOpacity(
                      0.2,
                    ),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
              ),

              child: Column(
                children: [
                  const Icon(
                    Icons.laptop_mac,
                    size: 80,
                    color:
                        Colors.redAccent,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  const Text(
                    'PRODUCT',
                    textAlign:
                        TextAlign.center,
                    style: TextStyle(
                      color:
                          Colors.white,
                      fontSize: 22,
                      fontWeight:
                          FontWeight
                              .bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // NAMA PRODUK
                  TextField(
                    controller:
                        nameController,
                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                    ),
                    decoration:
                        InputDecoration(
                      labelText:
                          'Nama Produk',
                      labelStyle:
                          const TextStyle(
                        color:
                            Colors.white70,
                      ),
                      prefixIcon:
                          const Icon(
                        Icons.shopping_bag,
                        color: Colors
                            .redAccent,
                      ),
                      filled: true,
                      fillColor:
                          Colors.black26,
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          15,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // HARGA
                  TextField(
                    controller:
                        priceController,
                    keyboardType:
                        TextInputType
                            .number,
                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                    ),
                    decoration:
                        InputDecoration(
                      labelText:
                          'Harga',
                      labelStyle:
                          const TextStyle(
                        color:
                            Colors.white70,
                      ),
                      prefixIcon:
                          const Icon(
                        Icons.attach_money,
                        color: Colors
                            .redAccent,
                      ),
                      filled: true,
                      fillColor:
                          Colors.black26,
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          15,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // DESKRIPSI
                  TextField(
                    controller:
                        descriptionController,
                    maxLines: 5,
                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                    ),
                    decoration:
                        InputDecoration(
                      labelText:
                          'Deskripsi',
                      alignLabelWithHint:
                          true,
                      labelStyle:
                          const TextStyle(
                        color:
                            Colors.white70,
                      ),
                      prefixIcon:
                          const Padding(
                        padding:
                            EdgeInsets.only(
                          bottom: 90,
                        ),
                        child: Icon(
                          Icons.description,
                          color: Colors
                              .redAccent,
                        ),
                      ),
                      filled: true,
                      fillColor:
                          Colors.black26,
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          15,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 35,
                  ),

                  // BUTTON
                  SizedBox(
                    width:
                        double.infinity,
                    height: 55,

                    child:
                        ElevatedButton(
                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            Colors
                                .redAccent,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            15,
                          ),
                        ),
                      ),

                      onPressed:
                          isLoading
                              ? null
                              : saveProduct,

                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors
                                  .white,
                            )
                          : const Text(
                              'SIMPAN PRODUK',
                              style:
                                  TextStyle(
                                color: Colors
                                    .white,
                                fontSize:
                                    18,
                                fontWeight:
                                    FontWeight
                                        .bold,
                                letterSpacing:
                                    1,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}