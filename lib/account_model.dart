class AccountModel {
  String? name;
  String userName;
  String password;

  AccountModel({
    this.name,
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name ?? 'Khong xac dinh',
      'userName': userName,
      'password': password,
    };
  }

  static AccountModel fromJson(Map<String, dynamic> json) {
    return AccountModel(
      name: json['name'],
      userName: json['userName'],
      password: json['password'],
    );
  }

  @override
  String toString() {
    return "{'name': '$name', 'userName': '$userName', 'password': '$password'}";
  }
}
