import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dexter_test/core/constants/firebase_constants.dart';
import 'package:dexter_test/core/constants/variables.dart';
import 'package:dexter_test/core/utils/app_error.dart';
import 'package:dexter_test/core/utils/error_or.dart';
import 'package:dexter_test/features/dashboard/data/models/task.dart';
import 'package:dexter_test/features/dashboard/domain/entities/progress.dart';
import 'package:dexter_test/features/dashboard/domain/entities/task.dart';
import 'package:dexter_test/features/dashboard/domain/entities/tasks_container.dart';
import 'package:dexter_test/features/dashboard/domain/repos/tasks_repo.dart';

class FireTaskRepo extends ITaskRepo {
  @override
  AsyncErrorOr<AllTasks> getTasks() async {
    try {
      Stream<List<TaskModel>> queryConverter(
        Query<Map<String, dynamic>> result,
      ) {
        return result
            .orderBy('time_created', descending: true)
            .snapshots()
            .map((event) {
          return event.docs.map((e) => TaskModel.fromMap(e.data())).toList();
        });
      }

      final collection = firestore.collection(FireStoreConsts.tasksColl);
      final completed =
          collection.where('progress', isEqualTo: TaskProgress.complete.id);
      final ongoing =
          collection.where('progress', isEqualTo: TaskProgress.incomplete.id);

      return Right(AllTasks(
        ongoingTasks: queryConverter(ongoing),
        completedTasks: queryConverter(completed),
      ));
    } catch (e) {
      return const Left(AppError());
    }
  }

  @override
  AsyncErrorOr<void> addTask(TaskItem task) async {
    try {
      final doc = firestore.collection(FireStoreConsts.tasksColl).doc();
      await doc.set(
        task.toMap(doc.id)..['time_created'] = FieldValue.serverTimestamp(),
      );
      return const Right(null);
    } catch (_) {
      return const Left(AppError());
    }
  }

  @override
  AsyncErrorOr<void> updateTask(TaskItem task) async {
    try {
      final doc = firestore.collection(FireStoreConsts.tasksColl).doc(task.id);
      await doc.update(
        task.toMap()..['time_updated'] = FieldValue.serverTimestamp(),
      );
      return const Right(null);
    } catch (_) {
      return const Left(AppError());
    }
  }

  @override
  AsyncErrorOr<void> deleteTask(TaskItem task) async {
    try {
      final doc = firestore.collection(FireStoreConsts.tasksColl).doc(task.id);
      await doc.delete();
      return const Right(null);
    } catch (_) {
      return const Left(AppError());
    }
  }
}
