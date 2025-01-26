import 'package:flutter/material.dart';
import '../repositories/subject_repository.dart';

class SubjectProvider with ChangeNotifier {
  final SubjectRepository _repository;

  SubjectProvider(this._repository) {
    _loadSubjects();
  }

  // Getter para obter a lista de disciplinas
  List<Map<String, dynamic>> get subjects => _repository.getSubjects();

  // Método para carregar as disciplinas do repositório
  Future<void> _loadSubjects() async {
    await _repository.loadSubjects();
    notifyListeners();
  }

  // Método para adicionar uma nova disciplina
  void addSubject(String name, int hours, IconData icon, Color color) {
    _repository.addSubject(name, hours, icon, color);
    notifyListeners();
  }

  // Método para excluir uma disciplina
  void deleteSubject(Map<String, dynamic> subject) {
    _repository.deleteSubject(subject);
    notifyListeners();
  }

  // Método para atualizar uma disciplina existente
  void updateSubject(Map<String, dynamic> subject, String name, int hours, IconData icon, Color color) {
    _repository.updateSubject(subject, name, hours, icon, color);
    notifyListeners();
  }
}