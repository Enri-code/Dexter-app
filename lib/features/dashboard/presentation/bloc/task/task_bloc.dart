import 'dart:async';
import 'package:dexter_test/core/utils/app_error.dart';
import 'package:dexter_test/core/utils/operation_status.dart';
import 'package:dexter_test/features/dashboard/domain/entities/task.dart';
import 'package:dexter_test/features/dashboard/domain/repos/tasks_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(this._repo) : super(const TaskState()) {
    on<GetTasks>(_getTasks);
    on<AddTask>(_addTask);
    on<UpdateTask>(_updateTask);
    on<DeleteTask>(_deleteTask);
  }

  final ITaskRepo _repo;

  Future _getTasks(GetTasks event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    final result = await _repo.getTasks();
    result.fold(
      (l) {
        emit(state.copyWith(error: l, status: OperationStatus.error));
      },
      (r) {
        emit(state.copyWith(
          error: null,
          ongoingTasks: r.ongoingTasks,
          completedTasks: r.completedTasks,
          status: OperationStatus.success,
        ));
      },
    );
  }

  Future _addTask(AddTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    final result = await _repo.addTask(event.task);
    result.fold(
      (l) {
        emit(state.copyWith(error: l, status: OperationStatus.error));
      },
      (r) {
        emit(state.copyWith(error: null, status: OperationStatus.success));
      },
    );
  }

  Future _updateTask(UpdateTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    final result = await _repo.updateTask(event.task);
    result.fold(
      (l) {
        emit(state.copyWith(error: l, status: OperationStatus.error));
      },
      (r) {
        emit(state.copyWith(error: null, status: OperationStatus.success));
      },
    );
  }

  Future _deleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    final result = await _repo.deleteTask(event.task);
    result.fold(
      (l) {
        emit(state.copyWith(error: l, status: OperationStatus.error));
      },
      (r) {
        emit(state.copyWith(error: null, status: OperationStatus.success));
      },
    );
  }
}
