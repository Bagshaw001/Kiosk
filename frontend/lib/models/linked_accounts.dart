
enum SocialMediaPlatform{
  instagram,
  whatsapp
}

class LinkedAccount{
  final String storeId;
  final String apiKey;
  final SocialMediaPlatform platform;
  final DateTime dateAdded;
  final DateTime? dateExpiry;
  final String token;

  LinkedAccount({
    required this.storeId,
    required this.apiKey,
    required this.dateExpiry,
    required this.token,
    required this.platform,
    required this.dateAdded
});


  factory LinkedAccount.fromJson(Map<String,dynamic> map) => LinkedAccount(
      storeId: map["store_id"],
      apiKey : map["api_key"],
      token: map["access_token"],
      platform: SocialMediaPlatform.values.firstWhere((element) => element.name == map["platform"]),
      dateAdded: DateTime.parse(map["date_added"]),
      dateExpiry: DateTime.parse(map["token_expiry"])
      );


}