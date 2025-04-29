import 'package:class_four_riverpod/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App Riverpod"),),
      body: Column(
        children: [
          // TextFormField to enter the name
          TextFormField(
            controller: ref.watch(todoProvider).queryController,
            decoration: const InputDecoration(
              hintText: 'What do people call you?',
              labelText: 'Name *',
            ),
            onChanged: (String? value) {
              ref.read(todoProvider.notifier).updateQuery(value);
            },
          ),
          // Display the entered text below the TextFormField
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("${ref.read(todoProvider).queryController?.text ?? ''}"),
          ),
          SizedBox(height: 20),  // Add space between fields and list

          // Expanded to make ListView flexible and take up remaining space
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: ref.watch(todoProvider).myTodo?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(ref.watch(todoProvider).myTodo?[index] ?? 'No Title'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,  // Adjust row size for icons
                    children: [
                      IconButton(
                        onPressed: () {
                         ref.read(todoProvider.notifier).updateTodo("update", index);
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          ref.read(todoProvider.notifier).deleteTodo(index);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20),  // Space between the ListView and button

          // Elevated Button to create a new todo item
          ElevatedButton(
            onPressed: () {
              ref.read(todoProvider.notifier).createTodoList(ref.read(todoProvider).queryController?.text);
            },
            child: Text("Create Todo"),
          ),
        ],
      ),
    );
  }
}
