class User {
   final String userId;
   String username;
   final String storeId;
   String storeName;
   String email;
  String? profileImage;

  User({
    required this.userId,
    required this.username,
    required this.storeId,
    required this.storeName,
    required this.email,
    required this.profileImage,
  });

  factory User.fromJson(Map<String,dynamic> map) {
    return User(
        userId: map["user_id"],
        storeId: map["store_id"],
        username: map["user_name"],
        email: map["email"],
      storeName: map["store_name"],
      profileImage: map["store_image"]
    );
  }

  Map<String,dynamic> toJson() => {
    "user_id" : userId,
    "user_name" : username,
    "email" : email,
    "store_name" : storeName,
    "store_id" : storeId
  };
}