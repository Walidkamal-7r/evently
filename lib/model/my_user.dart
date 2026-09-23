class MyUser {
  static const collectionName = 'user';

  String id;
  String name;
  String email;

  MyUser({required this.id, required this.name, required this.email});

  Map<String, dynamic> toJsonFirestore() {
    return {'id': id, 'name': name, 'email': email};
  }

  MyUser.fromJsonFirestore(Map<String, dynamic> data)
    : this(id: data['id'], name: data['name'], email: data['email']);
}
