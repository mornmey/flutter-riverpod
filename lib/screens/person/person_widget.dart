import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hor_pao/model/models.dart';
import 'package:hor_pao/state/person/person_state.dart';

final peopleProvider = ChangeNotifierProvider(((ref) => PersonState()));

class PersonWidget extends ConsumerWidget {
  const PersonWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Person"),
      ),
      body: Consumer(builder: (_, WidgetRef ref, __) {
        final dataModel = ref.watch(peopleProvider);
        return ListView.builder(
          itemCount: dataModel.count,
          itemBuilder: (context, index) {
            final person = dataModel.people[index];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () async {
                  final updatePerson = await createOrUpdatePersonDialog(
                    context,
                    person,
                  );
                  if (updatePerson != null) {
                    dataModel.updatePerson(updatePerson);
                  }
                },
                child: Text(person.displayName),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final person = await createOrUpdatePersonDialog(context);
          if (person != null) {
            final dataModel = ref.read(peopleProvider);
            dataModel.addPerson(person);
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createOrUpdatePersonDialog(
  BuildContext context, [
  Person? existingPerson,
]) {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age.toString();
  // ageController.text = age.toString().isEmpty ? age.toString() : '';

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Create a person"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Enter name here...'),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Enter age here...'),
              onChanged: (value) => age = int.tryParse(value),
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
              if (name != null && age != null) {
                if (existingPerson != null) {
                  /// update person
                  final updatePerson = existingPerson.updated(
                    name,
                    age,
                  );
                  Navigator.of(context).pop(updatePerson);
                } else {
                  /// create person
                  Navigator.of(context).pop(
                    Person(
                      name: name!,
                      age: age!,
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
