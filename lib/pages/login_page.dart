import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';
import 'product_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final usernameController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  bool isLoading = false;

  Future<void> login() async {

    setState(() {
      isLoading = true;
    });

    final token = await ApiService.login(
      usernameController.text,
      passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (token != null) {

      final prefs =
      await SharedPreferences.getInstance();

      await prefs.setString('token', token);

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder: (_) =>
          const ProductPage(),
        ),
      );

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text('Login gagal'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Center(

          child: SingleChildScrollView(

            padding:
            const EdgeInsets.all(24),

            child: Column(
              children: [

                const SizedBox(height: 30),

                Container(

                  width: 120,
                  height: 120,

                  decoration: BoxDecoration(

                    color:
                    const Color(0xFF5B67F1),

                    borderRadius:
                    BorderRadius.circular(35),
                  ),

                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.white,
                    size: 60,
                  ),
                ),

                const SizedBox(height: 40),

                Container(

                  padding:
                  const EdgeInsets.all(24),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(30),

                    boxShadow: [

                      BoxShadow(
                        color:
                        Colors.black.withOpacity(
                          0.04,
                        ),

                        blurRadius: 15,

                        offset:
                        const Offset(0, 8),
                      )
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      const Text(

                        'Selamat Datang',

                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(

                        'Silakan login untuk melanjutkan',

                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 35),

                      TextField(

                        controller:
                        usernameController,

                        decoration:
                        InputDecoration(

                          hintText:
                          'Masukkan username',

                          prefixIcon:
                          const Icon(
                            Icons.person,
                          ),

                          filled: true,

                          fillColor:
                          const Color(
                            0xFFF6F7FB,
                          ),

                          border:
                          OutlineInputBorder(

                            borderRadius:
                            BorderRadius.circular(
                              18,
                            ),

                            borderSide:
                            BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(

                        controller:
                        passwordController,

                        obscureText: true,

                        decoration:
                        InputDecoration(

                          hintText:
                          'Masukkan password',

                          prefixIcon:
                          const Icon(
                            Icons.lock,
                          ),

                          filled: true,

                          fillColor:
                          const Color(
                            0xFFF6F7FB,
                          ),

                          border:
                          OutlineInputBorder(

                            borderRadius:
                            BorderRadius.circular(
                              18,
                            ),

                            borderSide:
                            BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

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

                          onPressed: login,

                          child: isLoading

                              ? const CircularProgressIndicator(
                            color:
                            Colors.white,
                          )

                              : const Text(

                            'Login',

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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}