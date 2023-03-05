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
    String string = await rootBundle.loadString("json/tasks.json");
    final jsonData = await json.decode(string) as List<dynamic>;
    return jsonData.map((d) => Task.fromJson(d)).toList();
  }

  Future<void> add({required String text}) async {
    state = await AsyncValue.guard(() async {
      return [
        ...state.value ?? [],
        Task(id: uiKey(), text: text, completed: false),
      ];
    });
  }
}
