class Student {
  final String id;
  final String name;
  final String program;
  final String cohort;
  final bool active;

  Student({
    required this.id,
    required this.name,
    required this.program,
    required this.cohort,
    this.active = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'program': program,
      'cohort': cohort,
      'active': active,
    };
  }

  factory Student.fromMap(Map<dynamic, dynamic> map) {
    return Student(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      program: map['program'] ?? '',
      cohort: map['cohort'] ?? '',
      active: map['active'] ?? true,
    );
  }
}
