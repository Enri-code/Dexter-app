import 'package:dexter_test/app/presentation/theme/text.dart';
import 'package:dexter_test/app/presentation/widgets/user_avatar.dart';
import 'package:dexter_test/core/utils/custom_loader.dart';
import 'package:dexter_test/features/dashboard/presentation/bloc/task/task_bloc.dart';
import 'package:dexter_test/features/dashboard/presentation/widgets/completed_task.dart';
import 'package:dexter_test/features/dashboard/presentation/widgets/create_task_sheet.dart';
import 'package:dexter_test/features/dashboard/presentation/widgets/edit_task_sheet.dart';
import 'package:dexter_test/features/dashboard/presentation/widgets/ongoing_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const CreateTaskSheet(),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, size: 48, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Column(
            children: [
              Row(
                children: [
                  const UserAvatar(
                    size: 42,
                    imageUrl:
                        'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1671667200&v=beta&t=SxAGL3DIdlN39cVO4Z74WPti0cguELLK3Sydg7LuwiE',
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello,', style: MyTextStyles.faded),
                        const SizedBox(height: 2),
                        const Text(
                          'Eric Onyeulo!',
                          style: MyTextStyles.bold,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Morning', style: MyTextStyles.bold),
                  const SizedBox(width: 4),
                  const Icon(
                    CupertinoIcons.shift_fill,
                    color: Colors.green,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Expanded(child: _OngoingSection()),
              const SizedBox(height: 32),
              const _CompletedSection(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _OngoingSection extends StatelessWidget {
  const _OngoingSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ongoing', style: MyTextStyles.bold),
        const SizedBox(height: 12),
        BlocBuilder<TaskBloc, TaskState>(
          buildWhen: (prev, curr) {
            return prev.ongoingTasks != curr.ongoingTasks;
          },
          builder: (context, state) {
            return Expanded(
              child: Center(
                child: StreamBuilder(
                  stream: state.ongoingTasks,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CustomLoader.widget();
                    }
                    if (snapshot.data!.isEmpty) {
                      return const Text('There are no more tasks!');
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        final task = snapshot.data![index];
                        return Padding(
                          key: ValueKey(task.id),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => EditTaskSheet(task),
                              );
                            },
                            child: OngoingTaskWidget(task),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _CompletedSection extends StatelessWidget {
  const _CompletedSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Completed', style: MyTextStyles.bold),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          width: double.infinity,
          child: BlocBuilder<TaskBloc, TaskState>(
            buildWhen: (prev, curr) {
              return prev.completedTasks != curr.completedTasks;
            },
            builder: (context, state) {
              return Center(
                child: StreamBuilder(
                  stream: state.completedTasks,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CustomLoader.widget();
                    }
                    if (snapshot.data!.isEmpty) {
                      return const Text('There are no completed tasks!');
                    }
                    return ListView.builder(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          key: ValueKey(snapshot.data![index].id),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: CompletedTaskWidget(snapshot.data![index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
