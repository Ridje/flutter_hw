library task_1_taxi;

import 'package:task_1_taxi/task_1_taxi.dart';

void main(List<String> arguments) {
  int result = 0;
  for (var i = 0; i < 30; i++) {
    result = TarriffCounter.countTarriff(i + 1);
  }
  print("total amount: $result");
}
