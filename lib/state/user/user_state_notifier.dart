import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hor_pao/api_service.dart';
import 'package:hor_pao/model/models.dart';
import 'package:hor_pao/utils/exception.dart';

class UserStateNotifier extends StateNotifier<List<User>> {
  final ApiServices apiServices;
  UserStateNotifier({Key? key, required this.apiServices}) : super([]);

  final List<User> _user = [];

  int get count => _user.length;

  UnmodifiableListView<User> get user => UnmodifiableListView(_user);

  void addUser(User user) {
    print("Add user: $user");
    state = [...state, user];
  }

  void removeUser(User user) {
    print("Delete user:${user}");
    state = [...state.where((element) => element != user)];
  }

  void updateUser(int userID) {
    state = [
      for (final user in state)
        if (user.id == userID)
          user.update(
            email: user.email,
            firstName: user.firstName,
            lastName: user.lastName,
            avatar: user.avatar,
          )
        else
          user,
    ];
  }

  Future<List<User>> createUser({
    required User user,
  }) async {
    print("Create user: ${user}");
    try {
      return state = [...state, await apiServices.addUser(user: user)];
    } on AppException {
      rethrow;
    } catch (e) {
      return [];
    }
  }

  Future<List<User>> getUsers({
    int page = 2,
  }) async {
    try {
      return state = await apiServices.getUsers(
        query: {
          "page": page,
        },
      );
    } on AppException {
      /// let UIs catch the errors
      rethrow;
    } catch (e) {
      /// catch only app exception type
      return const [];
    }
  }
}
