import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// @immutable
// class User {
// final int id;
// final String email;
// final String firstName;
// final String lastName;
// final String avatar;
//
// const User({
// required this.id,
// required this.email,
// required this.firstName,
// required this.lastName,
// required this.avatar,
// });
//
// User update(
// [int? id,
// String? email,
// String? firstName,
// String? lastName,
// String? avatar]) =>
// User(
// id: id ?? this.id,
// email: email ?? this.email,
// firstName: firstName ?? this.firstName,
// lastName: lastName ?? this.lastName,
// avatar: avatar ?? this.avatar,
// );
//
// String get displayName => '$firstName $lastName';
// String get displayEmail => email;
// String get displayAvatar => avatar;
//
// @override
// bool operator ==(covariant User other) => id == other.id;
//
// @override
// int get hashCode => id.hashCode;
//
// @override
// String toString() {
// return 'Person(id: $id, email: $email, firstName: $firstName, lastName:$lastName, avatar:$avatar,)';
// }
// }

class User {
  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  User update({
    // int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) {
    return User(
      id: id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
    );
  }

  String get displayName => '$firstName $lastName';
  String get displayEmail => '$email';
  String get displayAvatar => '$avatar';

  @override
  bool operator ==(covariant User other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User(id: $id, email: $email, firstName: $firstName, lastName:$lastName, avatar: $avatar)';
  }

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

@immutable
class Person {
  final String name;
  final int age;
  final String uuid;

  Person({
    required this.name,
    required this.age,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  Person updated([String? name, int? age]) => Person(
        name: name ?? this.name,
        age: age ?? this.age,
        uuid: uuid,
      );

  String get displayName => '$name ($age years old)';

  @override
  bool operator ==(covariant Person other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  @override
  String toString() {
    return 'Person(name: $name, age: $age, uuid: $uuid)';
  }
}
