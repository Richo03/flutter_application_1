import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ApiService {

  // BASE URL API
  static const String baseUrl =
      'https://task.itprojects.web.id/api';

  // LOGIN
  static Future<String?> login(
      String username,
      String password,
      ) async {

    try {

      final response = await http.post(

        Uri.parse('$baseUrl/auth/login'),

        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },

        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print("========== LOGIN ==========");
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        return data['data']['token'];

      } else {

        return null;
      }

    } catch (e) {

      print("ERROR LOGIN:");
      print(e);

      return null;
    }
  }

// =========================
// GET PRODUCTS
// =========================
static Future<List<Product>> getProducts(
    String token,
    ) async {

  try {

    final response = await http.get(

      Uri.parse('$baseUrl/products'),

      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print("========== GET PRODUCT ==========");
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      // FIX FINAL
      List products = data['data']['products'];

      return products
          .map((e) => Product.fromJson(e))
          .toList();

    } else {

      return [];
    }

  } catch (e) {

    print("ERROR GET PRODUCT:");
    print(e);

    return [];
  }
}

  // =========================
  // ADD PRODUCT
  // =========================
  static Future<bool> addProduct(
      String token,
      String name,
      String description,
      int price,
      ) async {

    try {

      final response = await http.post(

        Uri.parse('$baseUrl/products'),

        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },

        body: jsonEncode({

          'name': name,
          'description': description,
          'price': price,
        }),
      );

      print("========== ADD PRODUCT ==========");
      print(response.statusCode);
      print(response.body);

      return response.statusCode == 200
          || response.statusCode == 201;

    } catch (e) {

      print("ERROR ADD PRODUCT:");
      print(e);

      return false;
    }
  }
}