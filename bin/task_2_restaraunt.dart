import 'package:hw_flutter/task_2_restaraunt.dart';

void main(List<String> arguments) {
  var dishes = [
    {Dish.coffee: 2, Dish.breakfastDish: 2},
    {Dish.coffee: 5},
    {Dish.tea: 1, Dish.breakfastDish: 1}
  ];
  final tax = (double value) => value - 1;
  final sale = (Dish dish) {
    var result = 0.0;
    if (dish == Dish.coffee) {
      result = (dish.price / 2 * 100).round() / 100;
    } else {
      result = dish.price;
    }
    return result;
  };
  Day.callItADay(dishes, sale, tax);
  print('');
  print('----------------------');
  print('Today we sold: ${Day.dishesOrderedToday} items');
}
