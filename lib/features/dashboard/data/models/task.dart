import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_test/features/dashboard/domain/entities/progress.dart';
import 'package:dexter_test/features/dashboard/domain/entities/shift.dart';
import 'package:dexter_test/features/dashboard/domain/entities/task.dart';

class TaskModel extends TaskItem {
  TaskModel._({
    required super.id,
    required super.title,
    required super.description,
    required super.shift,
    super.progress,
    super.timeCreated,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel._(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        progress: TaskProgress.fromValue(map['progress'] as String),
        shift: Shift.fromValue(map['shift'] as String),
        timeCreated: (map['time_created'] as Timestamp).toDate(),
      );
}
