import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey/presentation/pages/FormListPage.dart';

import 'providers/form_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FormProvider()..loadForms(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Manager',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const FormListPage(),
    );
  }
}
