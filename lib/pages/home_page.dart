import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../widgets/product_card.dart';

import 'add_product_page.dart';
import 'login_page.dart';
import 'submit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {
  List<ProductModel> products = [];

  bool isLoading = true;

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      products =
          await ApiService.getProducts();
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
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
          'LEGION STORE',
          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
            letterSpacing: 1,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () async {
              await StorageService.logout();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const LoginPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
          )
        ],
      ),

      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            )
          : products.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada produk',
                    style: TextStyle(
                      color:
                          Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )
              : RefreshIndicator(
                  color:
                      Colors.redAccent,
                  onRefresh:
                      fetchProducts,

                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(
                      15,
                    ),

                    itemCount:
                        products.length,

                    itemBuilder:
                        (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 15,
                        ),

                        child: ProductCard(
                          product:
                              products[index],
                        ),
                      );
                    },
                  ),
                ),

      floatingActionButton: Column(
        mainAxisAlignment:
            MainAxisAlignment.end,

        children: [
          FloatingActionButton(
            heroTag: 'add',

            backgroundColor:
                Colors.redAccent,

            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),

            onPressed: () async {
              final result =
                  await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const AddProductPage(),
                ),
              );

              if (result == true) {
                fetchProducts();
              }
            },
          ),

          const SizedBox(height: 15),

          FloatingActionButton(
            heroTag: 'submit',

            backgroundColor:
                Colors.green,

            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const SubmitPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}