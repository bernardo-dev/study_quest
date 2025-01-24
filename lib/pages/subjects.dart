import 'package:flutter/material.dart';

import '../widgets/AppDrawer.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  String selectedPage = 'Subjects';
  List<String> subjects = [];
  List<String> filteredSubjects = [];

  @override
  void initState() {
    super.initState();
    filteredSubjects = subjects;
  }

  // Method to add a new subject to the list
  void _addSubject(String subject) {
    setState(() {
      subjects.add(subject);
      filteredSubjects = subjects;
    });
  }

  // Method to show a dialog for adding a new subject
  void _showAddSubjectDialog() {
    String newSubject = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Subject'),
          content: TextField(
            onChanged: (value) {
              newSubject = value;
            },
            decoration: InputDecoration(hintText: "Subject Name"),
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
                  _addSubject(newSubject);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Method to navigate to the subject detail page
  void _navigateToSubjectDetail(String subject) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SubjectDetailPage(subject: subject, onDelete: _deleteSubject)),
    );
  }

  // Method to delete a subject
  void _deleteSubject(String subject) {
    setState(() {
      subjects.remove(subject);
      filteredSubjects = subjects;
    });
    Navigator.of(context).pop();
  }

  // Method to filter subjects based on the search query
  void _filterSubjects(String query) {
    setState(() {
      filteredSubjects = subjects
          .where((subject) => subject.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
                return ListTile(
                  title: Text(filteredSubjects[index]),
                  onTap: () => _navigateToSubjectDetail(filteredSubjects[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSubjectDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

class SubjectDetailPage extends StatelessWidget {
  final String subject;
  final Function(String) onDelete;

  const SubjectDetailPage({required this.subject, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
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
                          onDelete(subject);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Details for $subject'),
      ),
    );
  }
}