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

class CreateTaskSheet extends StatefulWidget {
  const CreateTaskSheet({super.key});

  @override
  State<CreateTaskSheet> createState() => _CreateTaskSheetState();
}

class _CreateTaskSheetState extends State<CreateTaskSheet> {
  String title = '', description = '';
  Shift shift = Shift.morning;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: bottomSheetDecoration,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create New Task',
              style: MyTextStyles.bold.copyWith(fontSize: 20),
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
                      minLines: 2,
                      maxLines: 5,
                      textInputAction: TextInputAction.done,
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
                          context.read<TaskBloc>().add(AddTask(TaskItem(
                                title: title,
                                description: description,
                                shift: shift,
                              )));
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
                          return const Text('Create Task');
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
