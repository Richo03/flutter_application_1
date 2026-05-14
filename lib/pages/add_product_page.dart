import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() =>
      _AddProductPageState();
}

class _AddProductPageState
    extends State<AddProductPage> {

  final nameController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  final priceController =
  TextEditingController();

  bool isLoading = false;

  Future<void> saveProduct() async {

    setState(() {
      isLoading = true;
    });

    final prefs =
    await SharedPreferences.getInstance();

    String token =
        prefs.getString('token') ?? '';

    final success =
    await ApiService.addProduct(

      token,

      nameController.text,

      descriptionController.text,

      int.tryParse(
        priceController.text,
      ) ?? 0,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
          Text('Produk berhasil ditambahkan'),
        ),
      );

      Navigator.pop(context, true);

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
          Text('Gagal menambahkan produk'),
        ),
      );
    }
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

          'Tambah Produk',

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 10),

            const Text(

              'Produk Baru',

              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(

              'Tambahkan produk ke katalog',

              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 35),

            buildInput(
              controller: nameController,
              hint: 'Nama Produk',
              icon: Icons.shopping_bag_rounded,
            ),

            const SizedBox(height: 20),

            buildInput(
              controller: descriptionController,
              hint: 'Deskripsi Produk',
              icon: Icons.description_rounded,
              maxLines: 4,
            ),

            const SizedBox(height: 20),

            buildInput(
              controller: priceController,
              hint: 'Harga Produk',
              icon: Icons.payments_rounded,
              keyboard:
              TextInputType.number,
            ),

            const SizedBox(height: 35),

            SizedBox(

              width: double.infinity,
              height: 55,

              child: ElevatedButton(

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  const Color(0xFF5B67F1),

                  foregroundColor:
                  Colors.white,

                  elevation: 0,

                  shape:
                  RoundedRectangleBorder(

                    borderRadius:
                    BorderRadius.circular(
                      18,
                    ),
                  ),
                ),

                onPressed: saveProduct,

                child: isLoading

                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )

                    : const Text(

                  'Simpan Produk',

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInput({

    required TextEditingController controller,
    required String hint,
    required IconData icon,

    int maxLines = 1,

    TextInputType keyboard =
        TextInputType.text,

  }) {

    return TextField(

      controller: controller,

      maxLines: maxLines,

      keyboardType: keyboard,

      decoration: InputDecoration(

        hintText: hint,

        prefixIcon: Icon(icon),

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(

          borderRadius:
          BorderRadius.circular(20),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}