import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/components/transaction_form.dart';

import 'components/transaction_form.dart';
import 'components/transactions_list.dart';
import '../models/transaction.dart';
void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis',
      value: 250.0,
      data: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Nova Camisa',
      value: 39.90,
      data: DateTime.now(),
    ),
  ];

    _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      data: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  _openTransactionFormModal(BuildContext context){
    showModalBottomSheet(context: context, builder: (_){
      return TransactionForm((p0, p1) {
        
      },);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas pessoais'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  [
            const SizedBox(
              child: Card(
                elevation: 5,
                child: Text('Grafico'),
              ),
            ),
            TransactionList(_transactions),
          ],         
        ),
      ),     
      floatingActionButton: FloatingActionButton(onPressed: () => _openTransactionFormModal(context),
      child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
