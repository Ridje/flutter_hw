class Day {
  static int dishesOrderedToday = 0;

  static get _amountUpdated => (int amount) => dishesOrderedToday += amount;

  static callItADay(
      List<Map<Dish, int>> dishes,
      double Function(Dish) dynamicSaleProcessor,
      double Function(double beforeTax) taxesProcessor) {
    for (final (index, item) in dishes.indexed) {
      print("______________");
      final amount = _OrderFactory.createOrder(item).calculateTotal(
          dynamicSaleProcessor, taxesProcessor,
          afterEachDish: _amountUpdated);
      print('order ${index + 1} has amount $amount');
    }
  }
}

class _OrderFactory {
  static _Order createOrder(Map<Dish, int> dishes) {
    return _Order(dishes);
  }
}

class _Order {
  Map<Dish, int> dishes;

  double calculateTotal(
      double Function(Dish) dynamicSale, double Function(double beforeTax) tax,
      {void Function(int)? afterEachDish}) {
    double finalAmount = 0;
    dishes.forEach((key, value) {
      final finalPrice = (tax(dynamicSale(key)));
      final finalSum = finalPrice * value;
      finalAmount += finalSum;
      afterEachDish?.call(value);
      print('Dish - $key: price = ${key.price}, price after tax = $finalPrice, amount = $value, final sum = $finalSum');
    });
    return finalAmount;
  }

  _Order(this.dishes);

  bool removeDish(Dish dish) {
    return dishes.remove(dish) != null;
  }

  bool addDish(Dish dish) {
    dishes.update(dish, (value) => value++, ifAbsent: () => 1);
    return true;
  }
}

enum Dish {
  coffee(5),
  tea(3),
  breakfastDish(10),
  businessLunch(20);

  final double price;

  const Dish(this.price);
}
