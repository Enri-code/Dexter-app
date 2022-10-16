import 'package:dexter_test/features/dashboard/domain/entities/progress.dart';
import 'package:dexter_test/features/dashboard/domain/entities/shift.dart';

class TaskItem {
  final String? id;
  final String title;
  final String description;
  final Shift shift;
  final TaskProgress progress;
  final DateTime? timeCreated;

  TaskItem({
    this.id,
    required this.title,
    required this.description,
    required this.shift,
    this.progress = TaskProgress.incomplete,
    this.timeCreated,
  });
/*
  final String? patientId;
  final String? shift;
  final String? nurseId; */

  Map<String, dynamic> toMap([String? id]) {
    return {
      'id': this.id ?? id,
      'title': title,
      'description': description,
      'progress': progress.id,
      'shift': shift.title,
    };
  }

  TaskItem copyWith({
    String? title,
    String? description,
    TaskProgress? progress,
    Shift? shift,
  }) {
    return TaskItem(
      title: title ?? this.title,
      description: description ?? this.description,
      progress: progress ?? this.progress,
      shift: shift ?? this.shift,
      timeCreated: timeCreated,
      id: id,
    );
  }
}
