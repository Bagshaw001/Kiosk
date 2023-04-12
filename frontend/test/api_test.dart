

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiosk/utils/api_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiosk/utils/user.dart';

void main() {
  const String email = "kwekuaacquaye@gmail.com";
  const String username = "Kweku - Test";
  String password = "testPassword1";
  String storeId = ""; //value set after test
  String userId = ""; //value set after test
  const String storeName = "Capstone - Test";
  const String country = "Ghana";
  const String phone = "233559582518";

  group('API Sign up Test', () {

    test('Testing sign up: response data should not be null & status code is 200', () async {
      final Map<String,dynamic> response = await ApiHandler.signup(
          username: username,
          phone: phone,
          email: email,
          password: password,
          storeName: storeName,
          country: country
      );
      expect(response["response"]["data"] == null,  false);
      expect(response["statusCode"] ,  200);
      if(response["response"]["data"] != null){
        userId = response["response"]["data"]["user_id"];
        storeId = response["response"]["data"]["store_id"];
      }
      //reset current store id if response has data

    });



  });

    group("API Sign In test", (){


      test("Wrong Credential Test - Response should be null", () async {
        //Test wrong password
        User? user = await ApiHandler.login(
            email: email,
            password: "wrong password"
        );
        expect(user, null);


        //Test wrong email
        user = await ApiHandler.login(
            email: "email@place.com",
            password: password
        );
        expect(user, null);
      });

      test("Correct Credential Test - Response should be of type user", () async {
        User? user = await ApiHandler.login(
            email: email,
            password: password
        );

        expect(user.runtimeType, User);
      });

    });






}