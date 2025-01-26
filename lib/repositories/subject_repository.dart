import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SubjectRepository {
  List<Map<String, dynamic>> _subjects = [];

  // Método para carregar as disciplinas do armazenamento
  Future<void> loadSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    final String? subjectsString = prefs.getString('subjects');
    if (subjectsString != null) {
      _subjects = List<Map<String, dynamic>>.from(json.decode(subjectsString));
    }
  }

  // Método para salvar as disciplinas no armazenamento
  Future<void> saveSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('subjects', json.encode(_subjects));
  }

  // Getter para obter a lista de disciplinas
  List<Map<String, dynamic>> getSubjects() {
    return _subjects;
  }

  // Método para adicionar uma nova disciplina
  void addSubject(String name, int hours, IconData icon, Color color) {
    _subjects.add({
      'name': name,
      'hours': hours,
      'icon': icon.codePoint,
      'color': color.value
    });
    saveSubjects();
  }

  // Método para excluir uma disciplina
  void deleteSubject(Map<String, dynamic> subject) {
    _subjects.remove(subject);
    saveSubjects();
  }

  // Método para atualizar uma disciplina existente
  void updateSubject(Map<String, dynamic> subject, String name, int hours, IconData icon, Color color) {
    subject['name'] = name;
    subject['hours'] = hours;
    subject['icon'] = icon.codePoint;
    subject['color'] = color.value;
    saveSubjects();
  }
}