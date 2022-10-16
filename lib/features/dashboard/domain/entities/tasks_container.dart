import 'package:dexter_test/features/dashboard/domain/entities/task.dart';

class AllTasks {
  final Stream<List<TaskItem>> ongoingTasks;
  final Stream<List<TaskItem>> completedTasks;

  AllTasks({required this.ongoingTasks, required this.completedTasks});
}
