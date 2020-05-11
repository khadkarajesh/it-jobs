import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobs/src/jobs/bloc/jobs_bloc.dart';
import 'package:jobs/src/jobs/bloc/jobs_event.dart';
import 'package:jobs/src/jobs/bloc/jobs_state.dart';
import 'package:jobs/src/jobs/models/job.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

class JobListScreen extends StatelessWidget {
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
  final List<Job> jobs;
  final bool hasReachedMax;

  JobList({Key key, @required this.jobs, @required this.hasReachedMax})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  List<Job> get jobs => widget.jobs;

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
    return Container(
      color: const Color(0xefefef),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int index) {
          return index >= jobs.length
              ? BottomLoader()
              : JobWidget(
                  job: jobs[index],
                );
        },
        itemCount: hasReachedMax ? jobs.length : jobs.length + 1,
        controller: _scrollController,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class JobWidget extends StatefulWidget {
  final Job job;

  const JobWidget({this.job});

  @override
  State<StatefulWidget> createState() => JobWidgetState();
}

class JobWidgetState extends State<JobWidget> {
  Job get job => widget.job;
  bool saved = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset(
                "assets/images/boy.png",
                height: 45,
                width: 45,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          job.title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              saved = !saved;
                            });
                          },
                          child: Icon(
                            saved ? Icons.bookmark : Icons.bookmark_border,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Text(
                      "NepNinja",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          transform: Matrix4.translationValues(-4, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Colors.grey,
                              ),
                              Align(
                                child: Text("Kathmandu Nepal"),
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                        Text(job.postedDate),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(job.employmentType),
                        Text(
                          "Apply for job",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
