class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(
        const Duration(seconds: 1), (time) => ticks - time - 1).take(ticks);
  }
}
