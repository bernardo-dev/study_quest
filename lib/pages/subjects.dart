import 'package:flutter/material.dart';

import '../widgets/AppDrawer.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  String selectedPage = 'Subjects';
  List<Map<String, dynamic>> subjects = [];
  List<Map<String, dynamic>> filteredSubjects = [];
  List<List<bool>> schedule = List.generate(24, (_) => List.generate(7, (_) => false));

  @override
  void initState() {
    super.initState();
    filteredSubjects = subjects;
  }

  // Method to add a new subject to the list
  void _addSubject(String subject, int hours, IconData icon, Color color) {
    setState(() {
      subjects.add({'name': subject, 'hours': hours, 'icon': icon, 'color': color});
      filteredSubjects = subjects;
    });
  }

  // Method to show a dialog for adding a new subject
  void _showAddSubjectDialog() {
    String newSubject = '';
    int selectedHours = 0;
    IconData selectedIcon = Icons.book;
    Color selectedColor = Colors.teal;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Subject'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newSubject = value;
                },
                decoration: InputDecoration(hintText: "Subject Name"),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Weekly Study Hours:'),
                  Spacer(),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return DropdownButton<int>(
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
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Select Icon:'),
                  Spacer(),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return DropdownButton<IconData>(
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
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Select Color:'),
                  Spacer(),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return DropdownButton<Color>(
                        value: selectedColor,
                        items: [
                          DropdownMenuItem(
                            value: Colors.teal,
                            child: Container(
                              width: 24,
                              height: 24,
                              color: Colors.teal,
                            ),
                          ),
                          DropdownMenuItem(
                            value: Colors.red,
                            child: Container(
                              width: 24,
                              height: 24,
                              color: Colors.red,
                            ),
                          ),
                          DropdownMenuItem(
                            value: Colors.blue,
                            child: Container(
                              width: 24,
                              height: 24,
                              color: Colors.blue,
                            ),
                          ),
                          DropdownMenuItem(
                            value: Colors.green,
                            child: Container(
                              width: 24,
                              height: 24,
                              color: Colors.green,
                            ),
                          ),
                        ],
                        onChanged: (Color? newValue) {
                          setState(() {
                            selectedColor = newValue!;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (newSubject.isNotEmpty) {
                  _addSubject(newSubject, selectedHours, selectedIcon, selectedColor);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Method to show a dialog for editing a subject
  void _showEditSubjectDialog(Map<String, dynamic> subject) {
    String updatedSubject = subject['name'];
    int updatedHours = subject['hours'];
    IconData updatedIcon = subject['icon'];
    Color updatedColor = subject['color'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Subject'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: updatedSubject),
                onChanged: (value) {
                  updatedSubject = value;
                },
                decoration: InputDecoration(hintText: "Subject Name"),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Weekly Study Hours:'),
                  Spacer(),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return DropdownButton<int>(
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
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Select Icon:'),
                  Spacer(),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return DropdownButton<IconData>(
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
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Select Color:'),
                  Spacer(),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return DropdownButton<Color>(
                        value: updatedColor,
                        items: [
                          DropdownMenuItem(
                            value: Colors.teal,
                            child: Container(
                              width: 24,
                              height: 24,
                              color: Colors.teal,
                            ),
                          ),
                          DropdownMenuItem(
                            value: Colors.red,
                            child: Container(
                              width: 24,
                              height: 24,
                              color: Colors.red,
                            ),
                          ),
                          DropdownMenuItem(
                            value: Colors.blue,
                            child: Container(
                              width: 24,
                              height: 24,
                              color: Colors.blue,
                            ),
                          ),
                          DropdownMenuItem(
                            value: Colors.green,
                            child: Container(
                              width: 24,
                              height: 24,
                              color: Colors.green,
                            ),
                          ),
                        ],
                        onChanged: (Color? newValue) {
                          setState(() {
                            updatedColor = newValue!;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _showDeleteConfirmationDialog(subject);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (updatedSubject.isNotEmpty) {
                  setState(() {
                    subject['name'] = updatedSubject;
                    subject['hours'] = updatedHours;
                    subject['icon'] = updatedIcon;
                    subject['color'] = updatedColor;
                    filteredSubjects = subjects;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Method to show a confirmation dialog before deleting a subject
  void _showDeleteConfirmationDialog(Map<String, dynamic> subject) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Subject'),
          content: Text('Are you sure you want to delete this subject?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteSubject(subject);
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Close the edit dialog as well
              },
            ),
          ],
        );
      },
    );
  }

  // Method to delete a subject
  void _deleteSubject(Map<String, dynamic> subject) {
    setState(() {
      subjects.remove(subject);
      filteredSubjects = subjects;
    });
  }

  // Method to filter subjects based on the search query
  void _filterSubjects(String query) {
    setState(() {
      filteredSubjects = subjects
          .where((subject) => subject['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Method to show the schedule dialog
  void _showScheduleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Available Times'),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Time')),
                  DataColumn(label: Text('Mon')),
                  DataColumn(label: Text('Tue')),
                  DataColumn(label: Text('Wed')),
                  DataColumn(label: Text('Thu')),
                  DataColumn(label: Text('Fri')),
                  DataColumn(label: Text('Sat')),
                  DataColumn(label: Text('Sun')),
                ],
                rows: List.generate(24, (hour) {
                  return DataRow(
                    cells: List.generate(8, (day) {
                      if (day == 0) {
                        return DataCell(Text('$hour:00'));
                      } else {
                        return DataCell(
                          Checkbox(
                            value: schedule[hour][day - 1],
                            onChanged: (bool? value) {
                              setState(() {
                                schedule[hour][day - 1] = value ?? false;
                              });
                            },
                          ),
                        );
                      }
                    }),
                  );
                }),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                // Add logic to save or process the schedule data here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPage),
      ),
      drawer: AppDrawer(
        selectedPage: selectedPage, // Passing the selected page to the Drawer
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
              onChanged: _filterSubjects,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSubjects.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: filteredSubjects[index]['color'],
                      child: Icon(filteredSubjects[index]['icon'], color: Colors.white),
                    ),
                    title: Text(
                      filteredSubjects[index]['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Weekly Study Hours: ${filteredSubjects[index]['hours']}h'),
                    trailing: Icon(Icons.edit),
                    onTap: () => _showEditSubjectDialog(filteredSubjects[index]),
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
            tooltip: 'Add Subject',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _showScheduleDialog,
            tooltip: 'Create Schedule',
            child: Icon(Icons.schedule),
          ),
        ],
      ),
    );
  }
}