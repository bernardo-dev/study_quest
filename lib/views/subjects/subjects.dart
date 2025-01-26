import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_drawer.dart';
import '../../providers/subject_provider.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});

  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  String selectedPage = 'Disciplinas';
  List<List<bool>> schedule = List.generate(24, (_) => List.generate(7, (_) => false));
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final subjectProvider = Provider.of<SubjectProvider>(context);
    final subjects = subjectProvider.subjects;

    // Filtrar disciplinas com base na consulta de pesquisa
    final filteredSubjects = subjects.where((subject) {
      final subjectName = subject['name'].toLowerCase();
      final query = searchQuery.toLowerCase();
      return subjectName.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPage),
      ),
      drawer: AppDrawer(
        selectedPage: selectedPage,
        onItemSelected: (String page) {
          setState(() {
            selectedPage = page;
          });
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSubjects.length,
              itemBuilder: (context, index) {
                final subject = filteredSubjects[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(subject['color']),
                      child: Icon(IconData(subject['icon'], fontFamily: 'MaterialIcons'), color: Colors.white),
                    ),
                    title: Text(
                      subject['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Horas Semanais de Estudo: ${subject['hours']}h'),
                    trailing: Icon(Icons.edit),
                    onTap: () => _showEditSubjectDialog(subject),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _showAddSubjectDialog,
            tooltip: 'Adicionar Disciplina',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _showAddSubjectDialog() {
    // Variáveis para armazenar os valores da nova disciplina
    String newSubject = '';
    int selectedHours = 0;
    IconData selectedIcon = Icons.book;
    Color selectedColor = Colors.teal;

    // Lista de cores disponíveis
    final List<Color> colors = [Colors.teal, Colors.red, Colors.blue, Colors.green];

    // Exibir o diálogo para adicionar uma nova disciplina
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Adicionar Disciplina'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Campo de texto para o nome da disciplina
                  TextField(
                    onChanged: (value) {
                      newSubject = value;
                    },
                    decoration: InputDecoration(hintText: "Nome da Disciplina"),
                  ),
                  SizedBox(height: 20),
                  // Dropdown para selecionar as horas semanais de estudo
                  Row(
                    children: [
                      Text('Horas Semanais de Estudo:'),
                      Spacer(),
                      DropdownButton<int>(
                        value: selectedHours,
                        items: List.generate(25, (index) => index).map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('$value h'),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedHours = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Dropdown para selecionar o ícone da disciplina
                  Row(
                    children: [
                      Text('Selecionar Ícone:'),
                      Spacer(),
                      DropdownButton<IconData>(
                        value: selectedIcon,
                        items: [
                          DropdownMenuItem(
                            value: Icons.book,
                            child: Icon(Icons.book),
                          ),
                          DropdownMenuItem(
                            value: Icons.science,
                            child: Icon(Icons.science),
                          ),
                          DropdownMenuItem(
                            value: Icons.computer,
                            child: Icon(Icons.computer),
                          ),
                          DropdownMenuItem(
                            value: Icons.calculate,
                            child: Icon(Icons.calculate),
                          ),
                        ],
                        onChanged: (IconData? newValue) {
                          setState(() {
                            selectedIcon = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Dropdown para selecionar a cor da disciplina
                  Row(
                    children: [
                      Text('Selecionar Cor:'),
                      Spacer(),
                      DropdownButton<Color>(
                        value: selectedColor,
                        items: colors.map((Color color) {
                          return DropdownMenuItem<Color>(
                            value: color,
                            child: Container(
                              width: 24,
                              height: 24,
                              color: color,
                            ),
                          );
                        }).toList(),
                        onChanged: (Color? newValue) {
                          setState(() {
                            selectedColor = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Adicionar'),
                  onPressed: () {
                    if (newSubject.isNotEmpty) {
                      // Usar o SubjectProvider para adicionar a nova disciplina
                      Provider.of<SubjectProvider>(context, listen: false).addSubject(
                        newSubject,
                        selectedHours,
                        selectedIcon,
                        selectedColor,
                      );
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditSubjectDialog(Map<String, dynamic> subject) {
    // Variáveis para armazenar os valores atualizados da disciplina
    String updatedSubject = subject['name'];
    int updatedHours = subject['hours'];
    IconData updatedIcon = IconData(subject['icon'], fontFamily: 'MaterialIcons');
    Color updatedColor = Color(subject['color']);

    // Controlador de texto para o campo de nome da disciplina
    TextEditingController subjectController = TextEditingController(text: updatedSubject);

    // Lista de cores disponíveis
    final List<Color> colors = [Colors.teal, Colors.red, Colors.blue, Colors.green];

    // Verificar se a cor inicial está na lista de cores
    if (!colors.contains(updatedColor)) {
      colors.add(updatedColor);
    }

    // Exibir o diálogo para editar a disciplina
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Editar Disciplina'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Campo de texto para o nome da disciplina
                  TextField(
                    controller: subjectController,
                    onChanged: (value) {
                      updatedSubject = value;
                    },
                    decoration: InputDecoration(hintText: "Nome da Disciplina"),
                  ),
                  SizedBox(height: 20),
                  // Dropdown para selecionar as horas semanais de estudo
                  Row(
                    children: [
                      Text('Horas Semanais de Estudo:'),
                      Spacer(),
                      DropdownButton<int>(
                        value: updatedHours,
                        items: List.generate(25, (index) => index).map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('$value h'),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            updatedHours = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Dropdown para selecionar o ícone da disciplina
                  Row(
                    children: [
                      Text('Selecionar Ícone:'),
                      Spacer(),
                      DropdownButton<IconData>(
                        value: updatedIcon,
                        items: [
                          DropdownMenuItem(
                            value: Icons.book,
                            child: Icon(Icons.book),
                          ),
                          DropdownMenuItem(
                            value: Icons.science,
                            child: Icon(Icons.science),
                          ),
                          DropdownMenuItem(
                            value: Icons.computer,
                            child: Icon(Icons.computer),
                          ),
                          DropdownMenuItem(
                            value: Icons.calculate,
                            child: Icon(Icons.calculate),
                          ),
                        ],
                        onChanged: (IconData? newValue) {
                          setState(() {
                            updatedIcon = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Dropdown para selecionar a cor da disciplina
                  Row(
                    children: [
                      Text('Selecionar Cor:'),
                      Spacer(),
                      DropdownButton<Color>(
                        value: updatedColor,
                        items: colors.map((Color color) {
                          return DropdownMenuItem<Color>(
                            value: color,
                            child: Container(
                              width: 24,
                              height: 24,
                              color: color,
                            ),
                          );
                        }).toList(),
                        onChanged: (Color? newValue) {
                          setState(() {
                            updatedColor = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Excluir'),
                  onPressed: () {
                    // Usar o SubjectProvider para excluir a disciplina
                    Provider.of<SubjectProvider>(context, listen: false).deleteSubject(subject);
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Salvar'),
                  onPressed: () {
                    if (updatedSubject.isNotEmpty) {
                      // Usar o SubjectProvider para atualizar a disciplina
                      Provider.of<SubjectProvider>(context, listen: false).updateSubject(
                        subject,
                        updatedSubject,
                        updatedHours,
                        updatedIcon,
                        updatedColor,
                      );
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}