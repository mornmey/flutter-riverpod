import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hor_pao/model/models.dart';
import 'package:hor_pao/provider/provider.dart';

class UserDetailWidget extends ConsumerWidget {
  final User user;
  const UserDetailWidget({
    Key? key,
    required this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataModel = ref.read(userNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.purple,
          ),
        ),
        title: const Text(
          "Edit Account",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          user.avatar ?? "https://www.logodesign.net/images/nature-logo.png"),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user.displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text("${user.email}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final updateUser = await createOrUpdateUserDialog(
            context,
            user,
          );
          if (updateUser != null) {
            print(">>>User: ${updateUser}");
            dataModel.updateUser(updateUser.id!);
          } else {
            print("errrr");
          }
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.edit),
      ),
    );
  }
}

// final idController = TextEditingController();
final firstNameController = TextEditingController();
final lastNameController = TextEditingController();
final emailController = TextEditingController();

Future<User?> createOrUpdateUserDialog(
  BuildContext context, [
  User? existingUser,
]) {
  // int? id = existingUser?.id;
  String? email = existingUser?.email;
  String? firstName = existingUser?.firstName;
  String? lastName = existingUser?.lastName;
  // String? avatar = existingUser?.avatar;

  // idController.text = '13';
  emailController.text = email ?? '';
  firstNameController.text = firstName ?? '';
  lastNameController.text = lastName ?? '';

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("User Info"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'Enter first name here...'),
              onChanged: (value) => firstName = value,
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Enter last name here...'),
              onChanged: (value) => lastName = value,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Enter email here...'),
              onChanged: (value) => email = value,
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (firstName != null && lastName != null && email != null) {
                if (existingUser != null) {
                  /// update user
                  final updateUser = existingUser.update(
                    // "13",
                    email: email,
                    firstName: firstName,
                    lastName: lastName,
                    // avatar: avatar,
                  );
                  print("User up: $updateUser");
                  Navigator.of(context).pop(updateUser);
                } else {
                  /// create user
                  Navigator.of(context).pop(
                    User(
                      id: 13,
                      email: email!,
                      firstName: firstName!,
                      lastName: lastName,
                    ),
                  );
                }
              } else {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
