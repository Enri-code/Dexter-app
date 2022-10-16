import 'package:dexter_test/app/presentation/theme/text.dart';
import 'package:dexter_test/core/utils/operation_status.dart';
import 'package:dexter_test/features/dashboard/domain/entities/progress.dart';
import 'package:dexter_test/features/dashboard/domain/entities/task.dart';
import 'package:dexter_test/features/dashboard/presentation/bloc/task/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedTaskWidget extends StatefulWidget {
  const CompletedTaskWidget(this.task, {super.key});

  final TaskItem task;

  @override
  State<CompletedTaskWidget> createState() => _CompletedTaskWidgetState();
}

class _CompletedTaskWidgetState extends State<CompletedTaskWidget> {
  late TaskItem task;

  @override
  void initState() {
    task = widget.task;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CompletedTaskWidget oldWidget) {
    setState(() => task = widget.task);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(blurRadius: 6, color: Colors.black12, offset: Offset(0, 4))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          widget.task.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: MyTextStyles.bold.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.task.description,
                          style: MyTextStyles.faded,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: widget.task.progress == TaskProgress.complete,
                    visualDensity: VisualDensity.compact,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      final taskBloc = context.read<TaskBloc>();
                      if (taskBloc.state.status == OperationStatus.loading) {
                        return;
                      }
                      final newTask = widget.task.copyWith(
                        progress: value == true
                            ? TaskProgress.complete
                            : TaskProgress.incomplete,
                      );
                      setState(() => task = newTask);
                      taskBloc.add(UpdateTask(newTask));
                    },
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1, height: 32),
            Row(children: [
              const SizedBox(width: 8),
              const Text('Shift: '),
              Text(task.shift.title, style: MyTextStyles.bold)
            ]),
          ],
        ),
      ),
    );
  }
}
