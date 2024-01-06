import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/states.dart';

class ArchiveTaskScreen extends StatelessWidget {
  const ArchiveTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,states){},
      builder: (context,states){
        var tasks = AppCubit.get(context).archiveTasks;
        return tasksBuilder(
          tasks: tasks,
        );
      },

    );
  }
}
