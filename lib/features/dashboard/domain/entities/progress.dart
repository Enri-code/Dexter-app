class TaskProgress {
  const TaskProgress._(this.id);
  factory TaskProgress.fromValue(String value) {
    if (value == complete.id) return complete;
    return incomplete;
  }

  static const complete = TaskProgress._('complete');
  static const incomplete = TaskProgress._('incomplete');

  final String id;

  @override
  operator ==(dynamic other) {
    return other is TaskProgress && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
