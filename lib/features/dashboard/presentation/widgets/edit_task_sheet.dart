import 'package:dexter_test/app/presentation/theme/properties.dart';
import 'package:dexter_test/app/presentation/theme/text.dart';
import 'package:dexter_test/core/utils/custom_loader.dart';
import 'package:dexter_test/core/utils/operation_status.dart';
import 'package:dexter_test/features/dashboard/domain/entities/shift.dart';
import 'package:dexter_test/features/dashboard/domain/entities/task.dart';
import 'package:dexter_test/features/dashboard/presentation/bloc/task/task_bloc.dart';
import 'package:dexter_test/features/dashboard/presentation/widgets/section_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTaskSheet extends StatefulWidget {
  const EditTaskSheet(this.task, {super.key});
  final TaskItem task;

  @override
  State<EditTaskSheet> createState() => _EditTaskSheetState();
}

class _EditTaskSheetState extends State<EditTaskSheet> {
  final formKey = GlobalKey<FormState>();
  String title = '', description = '';
  late Shift shift;

  @override
  void initState() {
    shift = widget.task.shift;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: bottomSheetDecoration,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                      onTap: () {
                        context.read<TaskBloc>().add(DeleteTask(widget.task));
                      },
                      child: Icon(
                        Icons.delete,
                        size: 28,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Edit Task',
                    style: MyTextStyles.bold.copyWith(fontSize: 20),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1, height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(title: Text('Title of task')),
                    TextFormField(
                      initialValue: widget.task.title,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Enter the title of this task',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please input the title of this task';
                        }
                        title = value;
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    const SectionHeader(title: Text('Description')),
                    TextFormField(
                      maxLines: 6,
                      minLines: 3,
                      initialValue: widget.task.description,
                      decoration: const InputDecoration(
                        hintText: 'Add more details about this task',
                      ),
                      validator: (value) {
                        description = value!;
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    const SectionHeader(title: Text('Shift')),
                    DropdownButtonFormField(
                      icon: const Icon(CupertinoIcons.shift_fill),
                      value: shift,
                      items: [Shift.morning, Shift.afternoon, Shift.evening]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.title, style: MyTextStyles.bold),
                              ))
                          .toList(),
                      onChanged: (value) => setState(() => shift = value!),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<TaskBloc>().add(UpdateTask(
                                widget.task.copyWith(
                                  title: title,
                                  description: description,
                                  shift: shift,
                                ),
                              ));
                        }
                      },
                      child: BlocConsumer<TaskBloc, TaskState>(
                        listener: (context, state) {
                          if (state.status == OperationStatus.success) {
                            Navigator.of(context).pop();
                          }
                        },
                        builder: (context, state) {
                          if (state.status == OperationStatus.loading) {
                            return Center(
                              child: CustomLoader.widget(Colors.white),
                            );
                          }
                          return const Text('Update Task');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
