part of 'task_bloc.dart';

abstract class TaskEvent {
  const TaskEvent();
}

class GetTasks extends TaskEvent {
  const GetTasks();
}

class AddTask extends TaskEvent {
  final TaskItem task;

  const AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final TaskItem task;

  const UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final TaskItem task;

  const DeleteTask(this.task);
}
