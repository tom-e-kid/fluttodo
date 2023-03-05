import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttodo/states/tasks.dart';

import '../views/input_form.dart';
import '../views/popup.dart';
import '../views/task_list.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(tasksProvider);
    return value.when(
      data: (tasks) => TaskList(
        tasks: tasks,
        onCompletion: (task, completed) {
          print(completed);
        },
      ),
      error: (error, stacktrace) => Text(error.toString()),
      loading: () => const Text('Loading...'),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<void> addTask(BuildContext context, WidgetRef ref) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Popup(
          onClosePressed: () {
            Navigator.pop(context);
          },
          child: InputForm(
            onSubmit: (text) {
              ref.read(tasksProvider.notifier).add(text: text);
              Navigator.pop(context);
              return true;
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fluttodo'),
      ),
      body: const SafeArea(
        child: Home(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addTask(context, ref);
        },
      ),
    );
  }
}
