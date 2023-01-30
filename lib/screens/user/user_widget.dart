import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hor_pao/provider/provider.dart';
import 'package:hor_pao/screens/user/user_detail_widget.dart';

class UserWidget extends ConsumerWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider);
    final users = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "User",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              color: Colors.white70,
              child: ListTile(
                onLongPress: () async {
                  final dataModel = ref.read(userNotifierProvider.notifier);
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
                  // ref.read(userNotifierProvider.notifier).removeUser(user);
                },
                onTap: () async {
                  print("user: $user");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserDetailWidget(
                        user: user,
                      ),
                    ),
                  );
                },
                title: Text(user.displayName),
                subtitle: Text("${user.email}"),
                trailing: const Icon(Icons.arrow_forward_ios),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      user.avatar ?? "https://www.logodesign.net/images/nature-logo.png"),
                ),
              ),
            ),
          );
        },
      ),
      // body: user.when(
      //   data: (users) {
      //     // List<User> userList = user.map((e) => e).toList();
      //     return Column(
      //       children: [
      //         Expanded(
      //           child: ListView.builder(
      //             itemCount: users.length,
      //             itemBuilder: (context, index) {
      //               final user = users[index];
      //               return Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 8),
      //                 child: Card(
      //                   color: Colors.white70,
      //                   child: ListTile(
      //                     onLongPress: () {
      //                       ref.read(userNotifierProvider.notifier).remove(user);
      //                     },
      //                     onTap: () {
      //                       print("user: $user");
      //                       Navigator.of(context).push(
      //                         MaterialPageRoute(
      //                           builder: (context) => UserDetailWidget(user: user),
      //                         ),
      //                       );
      //                     },
      //                     title: Text("${user.firstName} ${user.lastName}"),
      //                     subtitle: Text("${user.email}"),
      //                     trailing: const Icon(Icons.arrow_forward_ios),
      //                     leading: CircleAvatar(
      //                       backgroundImage: NetworkImage("${user.avatar}"),
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      //   error: (error, stackTrace) => Text(error.toString()),
      //   loading: () => const Center(child: CircularProgressIndicator()),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final user = await createOrUpdateUserDialog(context);
          if (user != null) {
            final dataModel = ref.read(userNotifierProvider.notifier);
            dataModel.addUser(user);
          }
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
