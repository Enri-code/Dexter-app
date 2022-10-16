part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState({
    this.status = OperationStatus.initial,
    this.error,
    this.ongoingTasks,
    this.completedTasks,
  });

  final AppError? error;
  final OperationStatus status;
  final Stream<List<TaskItem>>? ongoingTasks;
  final Stream<List<TaskItem>>? completedTasks;

  TaskState copyWith({
    AppError? error,
    OperationStatus? status,
    Stream<List<TaskItem>>? ongoingTasks,
    Stream<List<TaskItem>>? completedTasks,
  }) {
    return TaskState(
      error: error ?? this.error,
      status: status ?? this.status,
      ongoingTasks: ongoingTasks ?? this.ongoingTasks,
      completedTasks: completedTasks ?? this.completedTasks,
    );
  }

  @override
  List<Object?> get props => [error, ongoingTasks, completedTasks, status];
}
