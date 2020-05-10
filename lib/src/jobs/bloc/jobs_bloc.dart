import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobs/src/jobs/bloc/jobs_state.dart';
import 'package:jobs/src/jobs/repositories/job_repository.dart';
import './bloc.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  final JobRepository _jobRepository;

  JobsBloc({@required JobRepository jobRepository})
      : _jobRepository = jobRepository;

  @override
  JobsState get initialState => JobsState.initial();

  @override
  Stream<JobsState> mapEventToState(
    JobsEvent event,
  ) async* {
    yield* event.join<Stream<JobsState>>(
      (Fetch fetch) async* {
        yield* state.join<Stream<JobsState>>(
          (Initial initial) => _mapInitialAndFetchToState(initial, fetch),
          (Success success) => _mapSuccessAndFetchToState(success, fetch),
          (Failure failure) => _mapFailureAndFetchToState(failure, fetch),
        );
      },
    );
  }

  Stream<JobsState> _mapInitialAndFetchToState(
    Initial initial,
    Fetch fetch,
  ) async* {
    final posts = await _jobRepository.getJobs(20);
    yield JobsState.success(jobs: posts, hasReachedMax: false);
  }

  Stream<JobsState> _mapSuccessAndFetchToState(
    Success success,
    Fetch fetch,
  ) async* {
    if (!success.hasReachedMax) {
      final jobs = await _jobRepository.getJobs(20);
      yield jobs.isEmpty
          ? JobsState.success(jobs: success.jobs, hasReachedMax: true)
          : JobsState.success(
              jobs: success.jobs + jobs,
              hasReachedMax: false,
            );
    }
  }

  Stream<JobsState> _mapFailureAndFetchToState(
    Failure failure,
    Fetch fetch,
  ) async* {
    final jobs = await _jobRepository.getJobs(20);
    yield JobsState.success(jobs: jobs, hasReachedMax: false);
  }
}
