import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:jobs/src/jobs/models/job.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

class JobsState extends Union3Impl<Initial, Success, Failure> {
  static final unions = const Triplet<Initial, Success, Failure>();

  JobsState._(Union3<Initial, Success, Failure> union) : super(union);

  factory JobsState.initial() => JobsState._(unions.first(Initial()));

  factory JobsState.success({List<Job> jobs, bool hasReachedMax}) =>
      JobsState._(
          unions.second(Success(jobs: jobs, hasReachedMax: hasReachedMax)));
}

class Initial extends Equatable {
  @override
  List<Object> get props => [];
}

class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class Success extends Equatable {
  final List<Job> jobs;
  final bool hasReachedMax;

  const Success({this.jobs, this.hasReachedMax});

  @override
  List<Object> get props => [];
}
