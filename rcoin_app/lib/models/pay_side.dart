enum PaySide {
  unknown(0),
  sell(1),
  buy(2);

  final int value;

  const PaySide(this.value);

  factory PaySide.fromValue(int value) {
    return PaySide.values
        .firstWhere((element) => element.value == value, orElse: () => unknown);
  }
}
