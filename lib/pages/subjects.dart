import 'package:flutter/material.dart';

import '../widgets/AppDrawer.dart';


class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  String selectedPage = 'Disciplinas';

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

    );
  }
}