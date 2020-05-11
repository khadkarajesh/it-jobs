import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobs/src/jobs/models/job.dart';

class JobRepository {
  Future<List<Job>> getJobs(int limit) async {
    return (await Firestore.instance
            .collection("jobs")
            .orderBy("postedDate")
            .limit(limit)
            .getDocuments())
        .documents
        .map((e) => Job.fromJson(e.data))
        .toList();
  }
}
