
enum SocialMediaPlatform{
  instagram,
  whatsapp
}

class LinkedAccount{
  final String storeId;
  final String apiKey;
  final String accountName;
  final String accountId;
  final SocialMediaPlatform platform;
  final DateTime dateAdded;

  LinkedAccount({
    required this.storeId,
    required this.apiKey,
    required this.accountName,
    required this.accountId,
    required this.platform,
    required this.dateAdded
});


  factory LinkedAccount.fromJson(Map<String,dynamic> map) => LinkedAccount(
      storeId: map["store_id"],
      apiKey : map["api_key"],
      accountName : map["account_name"],
      accountId: map["account_id"],
      platform: SocialMediaPlatform.values.firstWhere((element) => element.name == map["platform"]),
      dateAdded: DateTime.parse(map["date_added"])
      );


}