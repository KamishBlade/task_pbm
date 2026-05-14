import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';
import 'storage_service.dart';

class ApiService {
  static const String baseUrl =
      'https://task.itprojects.web.id/api';

  // ================= LOGIN =================

  static Future<bool> login(
    String username,
    String password,
  ) async {
    try {
      final url = Uri.parse(
        '$baseUrl/auth/login',
      );

      final response = await http.post(
        url,
        headers: {
          'Content-Type':
              'application/json',
          'Accept':
              'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final data =
            jsonDecode(response.body);

        String token =
            data['data']['token'];

        print("TOKEN: $token");

        await StorageService.saveToken(
          token,
        );

        return true;
      }

      return false;
    } catch (e) {
      print("LOGIN ERROR: $e");
      return false;
    }
  }

  // ================= GET PRODUCTS =================

  static Future<List<ProductModel>>
      getProducts() async {
    try {
      final token =
          await StorageService.getToken();

      print("TOKEN: $token");

      final url = Uri.parse(
        '$baseUrl/products',
      );

      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer $token',
          'Accept':
              'application/json',
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final data =
            jsonDecode(response.body);

        // INI YANG BENAR
        List products =
            data['data']['products'];

        return products
            .map(
              (e) => ProductModel.fromJson(e),
            )
            .toList();
      }

      return [];
    } catch (e) {
      print("GET PRODUCT ERROR: $e");
      return [];
    }
  }

  // ================= ADD PRODUCT =================

  static Future<bool> addProduct(
    ProductModel product,
  ) async {
    try {
      final token =
          await StorageService.getToken();

      final url = Uri.parse(
        '$baseUrl/products',
      );

      final response = await http.post(
        url,
        headers: {
          'Authorization':
              'Bearer $token',
          'Content-Type':
              'application/json',
          'Accept':
              'application/json',
        },
        body: jsonEncode(
          product.toJson(),
        ),
      );

      print(response.statusCode);
      print(response.body);

      return response.statusCode == 200 ||
          response.statusCode == 201;
    } catch (e) {
      print("ADD PRODUCT ERROR: $e");
      return false;
    }
  }

  // ================= DELETE PRODUCT =================

  static Future<bool> deleteProduct(
    int id,
  ) async {
    try {
      final token =
          await StorageService.getToken();

      final url = Uri.parse(
        '$baseUrl/products/$id',
      );

      final response = await http.delete(
        url,
        headers: {
          'Authorization':
              'Bearer $token',
          'Accept':
              'application/json',
        },
      );

      print(response.statusCode);
      print(response.body);

      return response.statusCode == 200;
    } catch (e) {
      print("DELETE ERROR: $e");
      return false;
    }
  }

  // ================= SUBMIT TUGAS =================

  static Future<bool> submitTugas({
    required String name,
    required int price,
    required String description,
    required String githubUrl,
  }) async {
    try {
      final token =
          await StorageService.getToken();

      final url = Uri.parse(
        '$baseUrl/products/submit',
      );

      final response = await http.post(
        url,
        headers: {
          'Authorization':
              'Bearer $token',
          'Content-Type':
              'application/json',
          'Accept':
              'application/json',
        },
        body: jsonEncode({
          'name': name,
          'price': price,
          'description': description,
          'github_url': githubUrl,
        }),
      );

      print(response.statusCode);
      print(response.body);

      return response.statusCode == 200 ||
          response.statusCode == 201;
    } catch (e) {
      print("SUBMIT ERROR: $e");
      return false;
    }
  }
}