import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  final String title;
  final String experience;
  final String employmentType;
  final int salary;
  final String description;
  final String postedDate;

  Job(
      {this.title,
      this.experience,
      this.employmentType,
      this.salary,
      this.description,
      this.postedDate});

  factory Job.fromJson(Map<String, dynamic> data) {
    return Job(
        title: data['title'],
        experience: data['experince'],
        employmentType: data['employmentType'],
        salary: data['salary'],
        description: data['description'],
        postedDate: data['postedDate']);
  }
}

class Company {
  final String address;
  final String email;
  final String logo;
  final String phone;

  Company({this.address, this.email, this.logo, this.phone});
}
