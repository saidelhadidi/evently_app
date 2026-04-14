class UserModel {
  final String uid;
  final String userName;
  final String email;
  final String phoneNumber;
  final String profilePic;

  UserModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePic,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      userName: data['userName'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profilePic: data['profilePic'] ?? '',
    );
  }
}