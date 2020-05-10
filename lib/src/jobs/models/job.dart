class Job {
  final String title;
  final String jobType;
  final String company;
  final String experience;
  final String employmentType;
  final int salary;
  final String description;
  final String postedDate;

  Job(
      {this.title,
      this.jobType,
      this.company,
      this.experience,
      this.employmentType,
      this.salary,
      this.description,
      this.postedDate});

  factory Job.fromJson(Map<String, dynamic> data) {
    return Job(
        title: data['title'],
        jobType: data['jobType'],
        company: data['company'],
        experience: data['experince'],
        employmentType: data['employmentType'],
        salary: data['salary'],
        description: data['description'],
        postedDate: data['postedDate']);
  }
}
