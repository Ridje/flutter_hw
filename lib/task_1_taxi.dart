class TarriffCounter {
  static int countTarriff(int distance) {
    final currentTarriff = Tarriff.fromDistance(distance);
    final int amount = currentTarriff.tarriff * distance;
    print("distance: $distance, current amount: $amount, applied tarriff: $currentTarriff");
    return amount;
  }
}

enum Tarriff {
  short(250, 0),
  middle(200, 10),
  long(150, 20);

  final int tarriff;
  final int begin;

  const Tarriff(this.tarriff, this.begin);

  factory Tarriff.fromDistance(int distance) {
    var returnTarriff = Tarriff.short;
    for (var tarriff in Tarriff.values.reversed) {
      if (distance >= tarriff.begin) {
        returnTarriff = tarriff;
        break;
      }
    }
    return returnTarriff;
  }
}