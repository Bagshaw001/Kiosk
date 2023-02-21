import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:kiosk/models/product.dart";
import "package:kiosk/utils/user.dart";
import "package:kiosk/widgets/error_dialog.dart";

class ApiHandler {
  //=======================================================================================
  //    Start of database endpoints
  static Future<User?> login(
      {
        required BuildContext context,
        required String email,
        required String password}) async {

    http.Response response =  await _BaseHandler.post(
        endpoint: "database",
        body: {"action": "login", "email": email, "password": password});

    Map<String,dynamic> cred = json.decode(response.body);


    if (cred["statusCode"]== 200){
      // print("data " + cred["response"]["data"]);
      return User.fromJson(cred["response"]["data"]);

    } else {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context)=> ErrorDialog(
              text: cred["response"]["msg"]
          )
      );
    }

    return null;
  }

  static Future<void> signup({
    required String username,
    required String phone,
    required String email,
    required String password,
    required String storeName,
    required String country,
  }) async {
    http.Response res = await _BaseHandler.post(endpoint: "database", body: {
      "action": "create_account",
      "user_name": username,
      "phone_number": phone,
      "email": email,
      "store_name": storeName,
      "store_country": country,
      "password": password
    });

    Map<String, dynamic> response = json.decode(res.body);
    print(response["response"]["msg"]);
  }

  static Future<http.Response> inviteManager(String storeId) async {
    return _BaseHandler.post(
        endpoint: "database",
        body: {"action": "invite_manager", "store_id": storeId});
  }

  static Future<http.Response> generatePasswordToken(String email) async {
    return _BaseHandler.post(
        endpoint: "database",
        body: {"action": "generate_forgot_password_token", "email": email});
  }

  static Future<http.Response> resetPassword({
    required String password,
    required String token,
  }) async {
    return _BaseHandler.post(endpoint: "database", body: {
      "token": token,
      "password": password,
      "action": "reset_password"
    });
  }

  static Future<http.Response> uploadProduct(
      {required Product product}) async {

    return _BaseHandler.post(endpoint: "database",
        body: {
          "action": "upload_product",
          "product_name": product.name,
          "product_description": product.description,
          "store_id": product.storeId,
          "price" : product.price.toString(),
          "quantity" : product.quantity.toString(),
          "currency" : product.currency.name.toUpperCase()
        }
    );
  }
  static Future<http.Response> editProduct(
      {required Product product}) async {
    print("product id ${product.id}");
    return _BaseHandler.post(endpoint: "database",
        body: {
          "action": "update_product",
          "product_name": product.name,
          "product_description": product.description,
          "store_id": product.storeId,
          "price" : product.price.toString(),
          "quantity" : product.quantity.toString(),
          "currency" : product.currency.name.toUpperCase(),
          "product_id" : product.id
        }
    );
  }

  static Future<List<Product>> getProducts(String storeId) async{
    http.Response response = await _BaseHandler.post(endpoint: "database",
        body: {
          "action" : "get_products",
          "store_id" : storeId
        }
    );
    var json = jsonDecode(response.body);
    if(json["statusCode"] == 200){
      List<dynamic> maps = json["response"]["products"];
      return List.generate(maps.length, (index) => Product.fromJson(maps[index]));
    }
    return [];
  }

  static Future<http.Response> requestEmailVerification({
    required String userId
  }) async {
    return _BaseHandler.post(endpoint: "database", body: {
      "action" : "request_email_verification",
      "user_id" : userId
    });
  }

  static Future<http.Response> requestPhoneVerification({
    required String userId
  }) async {
    http.Response response = await _BaseHandler.post(
        endpoint: "database",
        body: {
      "action" : "request_phone_verification",
      "user_id" : userId
    });
    return response;
  }

  static Future<http.Response> verifyEmailToken({required String token}) async {
    return _BaseHandler.post(
        endpoint: "database",
        body: {
          "token" : token,
          "action": "verify_email"
        }
    );
  }
  static Future<http.Response> verifyPhoneToken({required String token}) async {
    return _BaseHandler.post(
        endpoint: "database",
        body: {
          "token" : token,
          "action" : "verify_phone"
        }
    );
  }
//    End of database endpoints
//=======================================================================================
}

class _BaseHandler {
  static String base = "http://137.184.228.209/kiosk/api/index.php";

  static String _genUrl(String endpoint) {
    // return base;
    return "$base/$endpoint";
  }

  static String _genArgs(Map<String, dynamic>? map) {
    String query = "";
    if (map != null) {
      map.forEach(((key, value) => query += "&$key=$value"));
      query = query.substring(1);
    }

    return query;
  }

  static Future<http.Response> get(String endpoint,
      {Map<String, dynamic>? body}) async {
    return await http.get(Uri(path: _genUrl(endpoint) + _genArgs(body)));
  }

  static Future<http.Response> post({required String endpoint, required Map<String, dynamic> body})
  async {

    return await http.post(
        Uri.parse(_genUrl(endpoint)),
        body: body
    );
  }
}
