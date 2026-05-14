import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF6F7FB),

      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(

          'Submit Project',

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

            // ======================
            // HEADER CARD
            // ======================

            Container(

              padding:
              const EdgeInsets.all(24),

              decoration: BoxDecoration(

                color:
                const Color(0xFF5B67F1),

                borderRadius:
                BorderRadius.circular(28),
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
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(

                          'PBM',

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
                      color: Colors.white,
                      size: 32,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 35),

            // ======================
            // NAMA PRODUK
            // ======================

            buildInput(

              controller: nameController,

              hint: 'Nama Produk',

              icon:
              Icons.shopping_bag_rounded,
            ),

            const SizedBox(height: 20),

            // ======================
            // DESKRIPSI
            // ======================

            buildInput(

              controller:
              descriptionController,

              hint: 'Deskripsi Produk',

              icon:
              Icons.description_rounded,

              maxLines: 4,
            ),

            const SizedBox(height: 20),

            // ======================
            // HARGA
            // ======================

            buildInput(

              controller: priceController,

              hint: 'Harga Produk',

              icon:
              Icons.payments_rounded,

              keyboard:
              TextInputType.number,
            ),

            const SizedBox(height: 20),

            // ======================
            // GITHUB
            // ======================

            buildInput(

              controller:
              githubController,

              hint: 'Link GitHub',

              icon: Icons.link,
            ),

            const SizedBox(height: 35),

            // ======================
            // BUTTON
            // ======================

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

                onPressed: () {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    const SnackBar(
                      content:
                      Text(
                        'Tugas berhasil disubmit',
                      ),
                    ),
                  );
                },

                child: const Text(

                  'Submit Tugas',

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

  // ======================
  // INPUT WIDGET
  // ======================

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