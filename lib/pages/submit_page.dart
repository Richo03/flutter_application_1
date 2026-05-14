import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class SubmitPage extends StatefulWidget {
  const SubmitPage({super.key});

  @override
  State<SubmitPage> createState() =>
      _SubmitPageState();
}

class _SubmitPageState
    extends State<SubmitPage> {

  final nameController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  final priceController =
  TextEditingController();

  final githubController =
  TextEditingController();

  List submissions = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadSubmissions();
  }

  Future<void> submitData() async {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    final githubUrl = githubController.text.trim();
    final price = int.tryParse(priceController.text.trim()) ?? 0;

    if (name.isEmpty || description.isEmpty || githubUrl.isEmpty || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field harus diisi dan harga harus valid'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isEmpty) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Token tidak ditemukan. Silakan login ulang.'),
        ),
      );
      return;
    }

    final success = await ApiService.submitProduct(
      token,
      name,
      description,
      price,
      githubUrl,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      final newItem = {
        'name': name,
        'description': description,
        'price': price,
        'github': githubUrl,
      };

      submissions = [...submissions, newItem];
      await prefs.setString('submissions', jsonEncode(submissions));

      nameController.clear();
      descriptionController.clear();
      priceController.clear();
      githubController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Project berhasil disubmit'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal submit project. Coba lagi.'),
        ),
      );
    }
  }


  Future<void> loadSubmissions() async {

    final prefs =
    await SharedPreferences.getInstance();

    final data =
    prefs.getString('submissions');

    if (data != null) {

      setState(() {

        submissions =
        jsonDecode(data);
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF6F7FB),

      appBar: AppBar(

        backgroundColor:
        Colors.transparent,

        elevation: 0,

        title: const Text(

          'Submit Project',

          style: TextStyle(
            color: Colors.black,
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


            Container(

              padding:
              const EdgeInsets.all(24),

              decoration: BoxDecoration(

                color:
                const Color(0xFF5B67F1),

                borderRadius:
                BorderRadius.circular(
                  28,
                ),
              ),

              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const Text(

                          'Upload Tugas',

                          style: TextStyle(
                            color:
                            Colors.white,

                            fontSize: 24,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        const Text(

                          'Isi data project dan link GitHub',

                          style: TextStyle(
                            color:
                            Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(

                    width: 65,
                    height: 65,

                    decoration: BoxDecoration(

                      color:
                      Colors.white.withOpacity(
                        0.15,
                      ),

                      borderRadius:
                      BorderRadius.circular(
                        20,
                      ),
                    ),

                    child: const Icon(

                      Icons.cloud_upload_rounded,

                      color:
                      Colors.white,

                      size: 32,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),


            buildInput(
              controller: nameController,
              hint: 'Nama Produk',
              icon:
              Icons.shopping_bag_rounded,
            ),

            const SizedBox(height: 20),

            buildInput(
              controller:
              descriptionController,

              hint: 'Deskripsi Produk',

              icon:
              Icons.description_rounded,

              maxLines: 4,
            ),

            const SizedBox(height: 20),

            buildInput(
              controller:
              priceController,

              hint: 'Harga Produk',

              icon:
              Icons.payments_rounded,

              keyboard:
              TextInputType.number,
            ),

            const SizedBox(height: 20),

            buildInput(
              controller:
              githubController,

              hint: 'Link GitHub',

              icon: Icons.link_rounded,
            ),

            const SizedBox(height: 35),


            SizedBox(

              width: double.infinity,
              height: 55,

              child: ElevatedButton(

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  const Color(
                    0xFF5B67F1,
                  ),

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

                onPressed: isLoading ? null : submitData,

                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 40),


            const Text(

              'Riwayat Submit',

              style: TextStyle(
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            if (submissions.isEmpty)

              Container(

                width: double.infinity,

                padding:
                const EdgeInsets.all(24),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(
                    24,
                  ),
                ),

                child: const Center(

                  child: Text(
                    'Belum ada data submit',
                  ),
                ),
              ),

            ...submissions.map((item) {

              return Container(

                margin:
                const EdgeInsets.only(
                  bottom: 16,
                ),

                padding:
                const EdgeInsets.all(18),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(
                    24,
                  ),

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

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(

                      item['name'],

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      item['description'],
                    ),

                    const SizedBox(height: 10),

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

                        'Rp ${item['price']}',

                        style: const TextStyle(

                          color:
                          Color(0xFF1FA971),

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(

                      item['github'],

                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildInput({

    required TextEditingController
    controller,

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