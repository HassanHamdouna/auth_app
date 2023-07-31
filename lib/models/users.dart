class Users {
  late String? id;
  late String? name;
  late String? email;
  late String? phone;
  late String? image;
  late String? password;

  Users();

  Users.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    password = data['password'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['password'] = password;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    return data;
  }
}
