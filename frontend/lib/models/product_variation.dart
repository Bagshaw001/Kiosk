

import 'package:kiosk/utils/constants.dart';

class ProductVariation{
  late Currency currency;
  late double price;
  String? productId;
   Map<String,dynamic> _details = {};

   Map<String,dynamic> get details => _details;


  ProductVariation({
    required this.currency,
    required this.price,
    this.productId,
    Map<String,dynamic>? details,
}){
    if(details != null){
      _details.addAll(details);
    }
  }

  bool addDetail(String key, dynamic value){
    if(!_details.keys.contains(key)){
      _details["key"] = value;
      return true;
    }
    return false;
  }

  bool removeDetail(String key){
    return _details.remove(key) != null;
  }

  ProductVariation.fromJson(Map<String,dynamic> map){
     ProductVariation(
        currency: map[""],
        price: map[""],
       details: map["details_json"],
       productId: map[""]
    );
  }

  Map<String,dynamic> asJson()=> {
    "product_id" : productId,
    "details_json" : details,
    "currency": currency.name,
    "price" : price
  };

}