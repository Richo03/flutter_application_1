import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';
import '../services/api_service.dart';
import 'add_product_page.dart';
import 'submit_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() =>
      _ProductPageState();
}

class _ProductPageState
    extends State<ProductPage> {

  List<Product> products = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getProducts();
  }

  Future<void> getProducts() async {

    final prefs =
    await SharedPreferences.getInstance();

    String token =
        prefs.getString('token') ?? '';

    final result =
    await ApiService.getProducts(token);

    setState(() {
      products = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF6F7FB),

      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(

          'Katalog Produk',

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),

        actions: [

          IconButton(

            onPressed: () {

              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (_) =>
                  const SubmitPage(),
                ),
              );
            },

            icon: const Icon(
              Icons.send_rounded,
              color: Colors.black87,
            ),
          )
        ],
      ),

      floatingActionButton:
      FloatingActionButton.extended(

        backgroundColor:
        const Color(0xFF5B67F1),

        foregroundColor: Colors.white,

        elevation: 1,

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
            getProducts();
          }
        },

        icon: const Icon(Icons.add),

        label: const Text('Tambah'),
      ),

      body: isLoading

          ? const Center(
        child: CircularProgressIndicator(),
      )

          : ListView(

        padding: const EdgeInsets.all(20),

        children: [

          Container(

            padding:
            const EdgeInsets.all(24),

            decoration: BoxDecoration(

              color:
              const Color(0xFF5B67F1),

              borderRadius:
              BorderRadius.circular(30),
            ),

            child: Row(
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      const Text(

                        'Halo gaiss',

                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(

                        'Kelola Produk',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight:
                          FontWeight.bold,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Container(

                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(

                          color:
                          Colors.white.withOpacity(
                            0.15,
                          ),

                          borderRadius:
                          BorderRadius.circular(
                            30,
                          ),
                        ),

                        child: Text(

                          '${products.length} Produk',

                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Container(

                  width: 80,
                  height: 80,

                  decoration: BoxDecoration(

                    color:
                    Colors.white.withOpacity(
                      0.15,
                    ),

                    borderRadius:
                    BorderRadius.circular(24),
                  ),

                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(

            'Daftar Produk',

            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          ...products.map((product) {

            return Container(

              margin:
              const EdgeInsets.only(
                bottom: 18,
              ),

              padding:
              const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(26),

                boxShadow: [

                  BoxShadow(
                    color:
                    Colors.black.withOpacity(
                      0.03,
                    ),

                    blurRadius: 10,

                    offset:
                    const Offset(0, 5),
                  )
                ],
              ),

              child: Row(
                children: [

                  Container(

                    width: 70,
                    height: 70,

                    decoration: BoxDecoration(

                      color:
                      const Color(
                        0xFFE9ECFF,
                      ),

                      borderRadius:
                      BorderRadius.circular(
                        22,
                      ),
                    ),

                    child: const Icon(
                      Icons.inventory_2_rounded,
                      color:
                      Color(0xFF5B67F1),
                      size: 34,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(

                          product.name,

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(

                          product.description,

                          style: const TextStyle(
                            color: Colors.grey,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Container(

                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(

                            color:
                            const Color(
                              0xFFE8FFF3,
                            ),

                            borderRadius:
                            BorderRadius.circular(
                              30,
                            ),
                          ),

                          child: Text(

                            'Rp ${product.price}',

                            style: const TextStyle(
                              color:
                              Color(0xFF1FA971),
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}