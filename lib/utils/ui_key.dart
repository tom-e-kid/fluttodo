import 'dart:math';

final rand = Random();

String uiKey() {
  final dateValue = DateTime.now().microsecondsSinceEpoch.toRadixString(32);
  final randomValue = rand.nextInt(100).toRadixString(32);
  return (dateValue + randomValue).substring(2, 10);
  ;
}
