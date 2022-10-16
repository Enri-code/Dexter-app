class Shift {
  const Shift._(this.title);
  factory Shift.fromValue(String value) {
    if (value == morning.title) return morning;
    if (value == afternoon.title) return afternoon;
    return evening;
  }

  static const morning = Shift._('Morning');
  static const afternoon = Shift._('Afternoon');
  static const evening = Shift._('Evening');

  final String title;

  @override
  operator ==(dynamic other) => other is Shift && other.title == title;

  @override
  int get hashCode => title.hashCode;
}
