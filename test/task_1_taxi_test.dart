import 'package:hw_flutter/task_1_taxi.dart';
import 'package:test/test.dart';

void main() {
  test('pass 1', () {
    expect(TarriffCounter.countTarriff(1), 250);
  });

  test('pass 0', () {
    expect(TarriffCounter.countTarriff(0), 0);
  });

  test('pass 10', () {
    expect(TarriffCounter.countTarriff(10), 10 * 200);
  });

  test('pass 11', () {
    expect(TarriffCounter.countTarriff(11), 11 * 200);
  });

    test('pass 20', () {
    expect(TarriffCounter.countTarriff(20), 20 * 150);
  });

  test('pass 21', () {
    expect(TarriffCounter.countTarriff(21), 21 * 150);
  });

  test('pass 30', () {
    expect(TarriffCounter.countTarriff(30), 30 * 150);
  });
}
