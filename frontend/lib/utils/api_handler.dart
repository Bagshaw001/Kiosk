import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:kiosk/models/product_variation.dart";
import "package:kiosk/utils/app_state.dart";
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
      {required String name,
      required String description,
      required String storeId,
      required Map<dynamic, dynamic> variations}) async {
    return _BaseHandler.post(endpoint: "database", body: {
      "product_name": name,
      "product_description": description,
      "store_id": storeId,
      "product_variations": variations
    });
  }

  static Future<http.Response> uploadVariation(
      ProductVariation variation) async {
    Map<String,dynamic> body = {"action": "add_product_variation"};
    body.addAll(variation.asJson());

    return _BaseHandler.post(endpoint: "database", body: body);
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
  // static String base = "http://127.0.0.1/.../.../";
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
