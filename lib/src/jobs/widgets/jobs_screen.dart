import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs/src/jobs/bloc/jobs_bloc.dart';
import 'package:jobs/src/jobs/widgets/job_list_screen.dart';

class JobsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateJobsScreen();
  }
}

class _StateJobsScreen extends State<JobsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => JobsBloc(),
      child: JobListScreen(),
    );
  }
}
