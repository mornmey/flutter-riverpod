import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentWidget extends StatefulWidget {
  @override
  State<StudentWidget> createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<StudentWidget> {
  late Map mapResponse;
  late Map dataResponse;
  late List listResponse = [];

  Future<void> apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse.addAll(mapResponse["data"]);
      });
    }
  }

  @override
  void initState() {
    apiCall();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Student"),
      ),
      body: ListView.builder(
        itemCount: listResponse.length,
        itemBuilder: (context, index) {
          final fullName =
              "${listResponse[index]["first_name"].toString()} ${listResponse[index]["last_name"].toString()}";
          return Visibility(
            visible: listResponse.isNotEmpty,
            replacement: Container(),
            child: ListTile(
              title: Text(fullName),
              subtitle: Text(listResponse[index]["email"].toString()),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  listResponse[index]["avatar"].toString(),
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          );
        },
      ),
    );
  }
}
