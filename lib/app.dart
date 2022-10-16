import 'package:dexter_test/app/presentation/theme/theme_data.dart';
import 'package:dexter_test/features/dashboard/data/repos/tasks_repo.dart';
import 'package:dexter_test/features/dashboard/domain/repos/tasks_repo.dart';
import 'package:dexter_test/features/dashboard/presentation/bloc/task/task_bloc.dart';
import 'package:dexter_test/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DexterApp extends StatelessWidget {
  const DexterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ITaskRepo>(
      create: (context) => FireTaskRepo(),
      child: Builder(builder: (context) {
        return BlocProvider.value(
          value: TaskBloc(context.read<ITaskRepo>())..add(const GetTasks()),
          child: MaterialApp(
            title: 'Dexter',
            theme: LightThemeBuilder(Colors.green).theme,
            home: const DashboardScreen(),
          ),
        );
      }),
    );
  }
}
