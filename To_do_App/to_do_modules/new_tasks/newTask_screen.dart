import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/shared/cubit/cubit.dart';
import 'package:untitled4/shared/cubit/states.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,states){},
      builder: (context,states){
        var tasks = AppCubit.get(context).newTasks;
        return  tasksBuilder(
          tasks: tasks,
        );

  }
);


  }
}
