import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:piggy_flow_mobile/models/account.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:piggy_flow_mobile/models/category.dart';
import 'package:piggy_flow_mobile/models/user.dart';
import 'package:piggy_flow_mobile/providers/http_client_provider.dart';
import 'package:piggy_flow_mobile/models/shop.dart';

final progressProvider = StateNotifierProvider<Progress, double>((ref) {
  return Progress();
});

class Progress extends StateNotifier<double> {
  Progress() : super(0);

  void reset() {
    state = 0;
  }

  void setProgress(double progress) {
    state = progress;
  }
}

final httpProvider = Provider<HttpHelper>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return HttpHelper(http: httpClient, ref: ref);
});

Map<String, String> headers = {
  'content-type': 'application/json',
};

class HttpHelper {
  HttpHelper({
    required this.http,
    required this.ref,
  });

  final BaseClient http;
  final Ref ref;
  final Map<String, String> headers = {
    'content-type': 'application/json',
  };

  Future<User?> authenticateUser() async {
    User? user;
    try {
      Response response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/user/login'),
      );

      user = User.fromJson(jsonDecode(response.body.toString()));
    } catch (e) {
      debugPrint('authenticateUser error: $e');
    }

    return user;
  }

  Future<List<Account>> getAccountsByUser() async {
    List<Account> accounts = [];

    try {
      Response response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/account/getAccountsByUser'),
      );

      for (var el in jsonDecode(response.body.toString())) {
        accounts.add(Account.fromJson(el));
      }
    } catch (e) {
      debugPrint('get accounts by user error: $e');
    }

    return accounts;
  }

  Future<bool> addAccount(Account account) async {
    try {
      await http.post(
        Uri.parse('${dotenv.env['API_URL']}/account'),
        headers: headers,
        body: jsonEncode(account.toJson()),
      );
      return true;
    } catch (e) {
      debugPrint('add new category error: $e');
      return false;
    }
  }

  Future<List<Shop>> getShopsByUser() async {
    List<Shop> shops = [];

    try {
      Response response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/shop/getShopsByUser'),
      );

      for (var el in jsonDecode(response.body.toString())) {
        shops.add(Shop.fromJson(el));
      }
    } catch (e) {
      debugPrint('get shops by user error: $e');
    }

    return shops;
  }

  Future<bool> addShop(Shop shop) async {
    try {
      await http.post(
        Uri.parse('${dotenv.env['API_URL']}/shop'),
        headers: headers,
        body: jsonEncode(shop.toJson()),
      );
      return true;
    } catch (e) {
      debugPrint('add new shop error: $e');
      return false;
    }
  }

  Future<List<Category>> getCategoriesByUser() async {
    List<Category> categories = [];

    try {
      Response response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/category/getCategoriesByUser'),
      );

      for (var el in jsonDecode(response.body.toString())) {
        categories.add(Category.fromJson(el));
      }
    } catch (e) {
      debugPrint('get categories by user error: $e');
    }

    return categories;
  }

  Future<bool> addCategory(Category category) async {
    try {
      await http.post(
        Uri.parse('${dotenv.env['API_URL']}/category'),
        headers: headers,
        body: jsonEncode(category.toJson()),
      );
      return true;
    } catch (e) {
      debugPrint('add new category error: $e');
      return false;
    }
  }

  Future<List<Bill>> getBillsByUser() async {
    List<Bill> bills = [];

    try {
      Response response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/bill/getBillsByUser'),
      );

      for (var el in jsonDecode(response.body.toString())) {
        bills.add(Bill.fromJson(el));
      }
    } catch (e) {
      debugPrint('get bills by user error: $e');
    }

    return bills;
  }

  Future<bool> addBill(Bill bill) async {
    try {
      await http.post(
        Uri.parse('${dotenv.env['API_URL']}/bill'),
        headers: headers,
        body: jsonEncode(bill.toJson()),
      );
      return true;
    } catch (e) {
      debugPrint('add new bill error: $e');
      return false;
    }
  }
}
