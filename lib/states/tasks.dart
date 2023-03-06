import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fluttodo/utils/ui_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/task.dart';

part 'tasks.g.dart';

@riverpod
class Tasks extends _$Tasks {
  @override
  Future<List<Task>> build() async {
    await Future.delayed(const Duration(seconds: 1));

    String string = await rootBundle.loadString("assets/tasks.json");
    final jsonData = await json.decode(string) as List<dynamic>;
    return jsonData.map((d) => Task.fromJson(d)).toList();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 1));
      return state.value ?? [];
    });
  }

  Future<void> add({required String text}) async {
    state = await AsyncValue.guard(() async {
      return [
        ...state.value ?? [],
        Task(id: uiKey(), text: text, completed: false),
      ];
    });
  }

  Future<void> patch({
    required String id,
    String? text,
    bool? completed,
  }) async {
    state = await AsyncValue.guard(() async {
      return state.value?.map(
            (t) {
              if (t.id == id) {
                return Task(
                  id: id,
                  text: text ?? t.text,
                  completed: completed ?? t.completed,
                );
              }
              return t;
            },
          ).toList() ??
          [];
    });
  }

  Future<void> remove({required String id}) async {
    state = await AsyncValue.guard(() async {
      return state.value?.where((t) => t.id != id).toList() ?? [];
    });
  }
}
