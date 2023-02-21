

import 'package:kiosk/utils/constants.dart';

class Product{
  final String name;
  String description;
  String storeId;
  String id;
  int quantity;
  double price;
  Currency currency;

  Product({
    required this.storeId,
    required this.name,
    this.id = "",
    required this.description,
    required this.quantity,
    required this.price,
    required this.currency
});


  factory Product.fromJson(Map<String,dynamic> map) => Product(
      name: map["product_name"],
      id: map["product_id"],
      storeId: map["store_id"],
      description: map["product_description"],
      quantity: int.parse(map["quantity"]),
      price: double.parse(map["price"]),
      currency: Currency.values.firstWhere((element) => element.name == map["currency"].toString().toLowerCase())
  );
}