import 'dart:io';

class Student {
  String fullName;
  int idNumber;
  List<String> subjects;
  List<double> grades;

  Student(this.fullName, this.idNumber, this.subjects, this.grades);

  void printReportCard(double average, String status) {
    const line = '=============================================';
    print('\n$line');
    print('||         UNIVERSITY GRADE REPORT         ||');
    print(line);
    print('Student : $fullName');
    print('ID No.  : $idNumber');
    print('---------------------------------------------');
    print('${'No.'.padRight(5)}${'Subject'.padRight(24)}Grade');
    print('---------------------------------------------');

    for (int i = 0; i < grades.length; i++) {
      String no = '${i + 1}.'.padRight(5);
      String subj = subjects[i].padRight(24);
      String gr = grades[i].toStringAsFixed(0).padLeft(6);
      print('$no$subj$gr');
    }

    print('---------------------------------------------');
    print('Average : ${average.toStringAsFixed(2)}');
    print('Status  : $status');
    print(line);
  }
}

String askText(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    if (input != null && input.trim().isNotEmpty) {
      return input.trim();
    }
    print('  Input cannot be empty. Try again.');
  }
}

int askInt(String prompt) {
  while (true) {
    stdout.write(prompt);
    int? value = int.tryParse(stdin.readLineSync() ?? '');
    if (value != null && value > 0) {
      return value;
    }
    print('  Please enter a valid positive whole number.');
  }
}

double askGrade(String prompt) {
  while (true) {
    stdout.write(prompt);
    String raw = (stdin.readLineSync() ?? '').trim();
    int? value = int.tryParse(raw);
    if (value != null && !raw.startsWith('0') && value >= 10 && value <= 100) {
      return value.toDouble(); 
    }
    print('  Grade must be a whole number from 10 to 100 (at least 2 digits).');
  }
}

double computeGrade(List<double> grades) {
  double total = 0;
  for (double g in grades) {
    total += g;
  }
  return total / grades.length;
}

void main() {
    print('====================================');
    print('|     STUDENT GRADE CALCULATOR     |');
    print('====================================\n');

  String name = askText('Enter full name   : ');
  int id = askInt('Enter ID number   : ');

  List<String> subjectNames = ['Computer Networking', 'Python Programming', 'Mobile Development'];
  List<double> gradeList = [];

  print('\nEnter the 3 subject grades (0-100):');
  for (int i = 0; i < 3; i++) {
    gradeList.add(askGrade('  Grade for ${subjectNames[i]}: '));
  }

  Student student = Student(name, id, subjectNames, gradeList);
  double average = computeGrade(student.grades);

  String status;
  if (average >= 75) {
    status = 'PASSED';
  } else if (average >= 70) {
    status = 'CONDITIONAL';
  } else {
    status = 'FAILED';
  }

  student.printReportCard(average, status);
}