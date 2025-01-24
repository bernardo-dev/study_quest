import 'package:flutter/material.dart';

import '../widgets/AppDrawer.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  String selectedPage = 'Subjects';
  List<String> subjects = [];

  void _addSubject(String subject) {
    setState(() {
      subjects.add(subject);
    });
  }

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

  void _navigateToSubjectDetail(String subject) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SubjectDetailPage(subject: subject)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPage),
      ),
      drawer: AppDrawer(
        selectedPage: selectedPage, // Passando a página selecionada para o Drawer
        onItemSelected: (String page) {
          setState(() {
            selectedPage = page;
          });
        },
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subjects[index]),
            onTap: () => _navigateToSubjectDetail(subjects[index]),
          );
        },
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

  const SubjectDetailPage({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
      ),
      body: Center(
        child: Text('Details for $subject'),
      ),
    );
  }
}