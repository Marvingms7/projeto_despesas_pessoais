import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final _transactions = [
    Transaction(
        id: 't1', title: 'Novo Tênis', value: 250.0, data: DateTime.now()),
    Transaction(
        id: 't2', title: 'Nova Camisa', value: 39.90, data: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas pessoais'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Card(
            elevation: 5,
            child: Text('Grafico'),
          ),
          Column(
              children: _transactions.map((tr) {
            return Card(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(tr.value.toString()),
                  ),
                  Column(
                    children: [Text(tr.title), Text(tr.data.toString())],
                  )
                ],
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
