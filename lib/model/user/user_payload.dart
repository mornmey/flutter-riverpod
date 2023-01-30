import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hor_pao/model/user/user_key.dart';

@immutable
class UserPlayload extends MapView<String, dynamic> {
  UserPlayload({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required String avatar,
  }) : super({
          UserKey.id: id,
          UserKey.email: email,
          UserKey.firstName: firstName,
          UserKey.lastName: lastName,
          UserKey.avatar: avatar,
        });
}
