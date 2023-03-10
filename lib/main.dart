import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'utils/logger.dart';
import 'widgets/screens/home.dart';

void main() async {
  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      child: const Bootstrap(),
    ),
  );
}

class ScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        // PointerDeviceKind.mouse, // activate dragging on web if you want.
      };
}

class Bootstrap extends ConsumerWidget {
  const Bootstrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Fluttodo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      scrollBehavior: ScrollBehavior(),
      home: const HomeScreen(),
    );
  }
}
