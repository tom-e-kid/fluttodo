import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttodo/utils/ui_key.dart';

import '../../models/task.dart';
import '../../states/tasks.dart';
import '../ui/pager.dart';
import '../ui/popup.dart';
import '../views/task_card.dart';
import '../views/task_input_form.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  Future<void> editTask(BuildContext context, WidgetRef ref, Task task) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Popup(
          onClosePressed: () {
            Navigator.pop(context);
          },
          child: TaskInputForm(
            placeholder: 'Edit task',
            initialText: task.text,
            onSubmit: (text) {
              ref.read(tasksProvider.notifier).patch(id: task.id, text: text);
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
    final value = ref.watch(tasksProvider);
    return value.when(
      data: (tasks) => Pager(
        key: Key(uiKey()),
        onRefresh: () async {
          ref.read(tasksProvider.notifier).refresh();
        },
        items: tasks,
        builder: (context, task) {
          return Dismissible(
            key: Key(task.id),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) {
              ref.read(tasksProvider.notifier).remove(id: task.id);
            },
            child: TaskCard(
              task: task,
              onComplete: (flag) {
                ref.read(tasksProvider.notifier).patch(
                      id: task.id,
                      completed: flag,
                    );
              },
              onSelect: () {
                editTask(context, ref, task);
              },
            ),
          );
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
          child: TaskInputForm(
            placeholder: 'Add task',
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
