import 'package:flutter/material.dart';
import 'package:hor_pao/model/user/user_key.dart';

@immutable
class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required Map<String, dynamic> json,
  })  : id = json[UserKey.id],
        email = json[UserKey.email],
        firstName = json[UserKey.firstName],
        lastName = json[UserKey.lastName],
        avatar = json[UserKey.avatar];

  String get displayName => '$firstName $lastName';
  String get displayEmail => email;
  String get displayAvatar => avatar;

  @override
  bool operator ==(covariant User other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Person(id: $id, email: $email, firstName: $firstName, lastName:$lastName, avatar:$avatar,)';
  }
}
