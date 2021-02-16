import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qq/utility/utility.dart';

enum UserRole { customer, manager }

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final UserRole role;

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
      role: json['role'] as UserRole,
    );
  }

  static User fromSnapShot(DocumentSnapshot snap) {
    return User(
      id: snap.id,
      email: snap.data()['email'] as String,
      name: snap.data()['name'] as String,
      role: Utility.enumFromString<UserRole>(
          snap.data()['role'] as String, UserRole.values),
    );
  }
}
