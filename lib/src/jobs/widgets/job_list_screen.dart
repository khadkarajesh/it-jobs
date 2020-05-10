import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobs/src/jobs/bloc/jobs_bloc.dart';
import 'package:jobs/src/jobs/bloc/jobs_event.dart';
import 'package:jobs/src/jobs/bloc/jobs_state.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

class JobListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateJobList();
  }
}

class _StateJobList extends State<JobListScreen> {
  @override
  Widget build(BuildContext context) {
    return SealedBlocBuilder3<JobsBloc, JobsState, Initial, Success, Failure>(
      builder: (context, states) {
        return states(
          (Initial initial) => Center(child: CircularProgressIndicator()),
          (Success success) => JobList(
            jobs: success.jobs,
            hasReachedMax: success.hasReachedMax,
          ),
          (Failure failure) => Center(
            child: Text('failed to fetch posts'),
          ),
        );
      },
    );
  }
}

class JobList extends StatefulWidget {
  final List<DocumentSnapshot> jobs;
  final bool hasReachedMax;

  JobList({Key key, @required this.jobs, @required this.hasReachedMax})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  List<DocumentSnapshot> get jobs => widget.jobs;

  bool get hasReachedMax => widget.hasReachedMax;

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  JobsBloc _jobsBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _jobsBloc.add(JobsEvent.fetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (jobs.isEmpty) {
      return Center(
        child: Text("No jobs"),
      );
    }
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return index >= jobs.length
            ? BottomLoader()
            : JobWidget(
                title: "Sr. Software Engineer",
              );
      },
      itemCount: hasReachedMax ? jobs.length : jobs.length + 1,
      controller: _scrollController,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class JobWidget extends StatelessWidget {
  final String title;

  const JobWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
