import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/components/transaction_form.dart';
import 'package:projeto_despesas_pessoais/components/transactions_list.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';

import 'components/transaction_user.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas pessoais'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Card(
            elevation: 5,
            child: Text('Grafico'),
          ),
          const TransactionUser(),
        ],
      ),
    );
  }
}
