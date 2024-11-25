  import 'package:flutter/material.dart';
  
  enum Department {finance, law, it, medical}
  enum Gender {male, female}
  
  const departmentIcons = {
    Department.finance: Icons.money,
    Department.law: Icons.account_balance,
    Department.it: Icons.computer,
    Department.medical: Icons.medical_services
  };

  const Map<Gender, Color> genderColors = {
    Gender.female: Colors.pink,
    Gender.male: Colors.blue
  };

  class Student {
    Student({
      required this.firstName,
      required this.lastName,
      required this.department,
      required this.grade,
      required this.gender
    });
    final String firstName;
    final String lastName;
    final Department department;
    final int grade;
    final Gender gender;
  }
