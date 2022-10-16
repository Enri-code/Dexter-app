import 'package:dexter_test/core/utils/error_or.dart';
import 'package:dexter_test/features/dashboard/domain/entities/task.dart';
import 'package:dexter_test/features/dashboard/domain/entities/tasks_container.dart';

abstract class ITaskRepo {
  AsyncErrorOr<AllTasks> getTasks();
  AsyncErrorOr<void> addTask(TaskItem task);
  AsyncErrorOr<void> updateTask(TaskItem task);
  AsyncErrorOr<void> deleteTask(TaskItem task);
}
