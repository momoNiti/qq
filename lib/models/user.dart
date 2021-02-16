import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String role;

  const User({
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.role,
  }) : assert(id != null, role != null);

  static const empty = User(id: '', email: '', name: null, role: null);
  @override
  List<Object> get props => [id, email, name, role];

  Map<String, Object> toJson() {
    return {
      'email': email,
      'name': name,
      'role': role,
    };
  }

  Map<String, Object> toDocument() {
    return {
      'email': email,
      'name': name,
      'role': role,
    };
  }

  static User fromJson(Map<String, Object> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
    );
  }

  static User fromSnapShot(DocumentSnapshot snap) {
    return User(
      id: snap.id,
      email: snap.data()['email'],
      name: snap.data()['name'],
      role: snap.data()['role'],
    );
  }
}
