import 'package:flutter/material.dart';
import 'package:korovina_sksm_24_1/models/student.dart';
import 'package:korovina_sksm_24_1/widgets/new_student.dart';
import 'package:korovina_sksm_24_1/widgets/student_item.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StudentsState();
  }
}

class _StudentsState extends State<Students> {
  final List<Student> _students_list = [
    Student(
        firstName: 'Pedro',
        lastName: 'Pascal',
        department: Department.law,
        grade: 99,
        gender: Gender.male),
    Student(
        firstName: 'Lara',
        lastName: 'Croft',
        department: Department.finance,
        grade: 95,
        gender: Gender.female),
    Student(
        firstName: 'Lain',
        lastName: 'Iwakura',
        department: Department.it,
        grade: 99,
        gender: Gender.female),
    Student(
        firstName: 'Eric',
        lastName: 'Draven',
        department: Department.medical,
        grade: 70,
        gender: Gender.male)
  ];

  void addStudent(Student student) {
    setState(() {
      _students_list.add(student);
    });
  }

  void _removeStudent(Student student) {
    final studentIndex = _students_list.indexOf(student);
    setState(() {
      _students_list.remove(student);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('You`ve deleted a student!'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _students_list.insert(studentIndex, student);
              });
            }),
      ),
    );
  }

  void _editStudent(Student student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewStudent(
        existingStudent: student,
        onAddStudent: (updatedStudent) {
          setState(() {
            final index = _students_list.indexOf(student);
            _students_list[index] = updatedStudent; // Update the student
          });
        },
      ),
    );
  }

  void _openAddStudentOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewStudent(onAddStudent: addStudent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
              onPressed: _openAddStudentOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(children: [
        Expanded(
          child: StudentsList(
              students: _students_list, onRemoveStudent: _removeStudent, onEditStudent: _editStudent),
        ),
      ]),
    );
  }
}

class StudentsList extends StatelessWidget {
  const StudentsList(
      {super.key, required this.students, required this.onRemoveStudent, required this.onEditStudent});

  final List<Student> students;
  final void Function(Student student) onRemoveStudent;
    final void Function(Student student) onEditStudent;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: students.length,
        itemBuilder: (contest, index) => Dismissible(
              key: ValueKey(students[index]),
              background: Container(
                color: Colors.red.withOpacity(0.75),
                margin: const EdgeInsets.symmetric(vertical: 5),
              ),
              child: StudentsItem(student: students[index], onEditStudent: onEditStudent),
              onDismissed: (direction) {
                onRemoveStudent(students[index]);
              },
            ));
  }
}
