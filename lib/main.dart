import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/components/chart.dart';
import 'package:projeto_despesas_pessoais/components/transaction_form.dart';
import 'components/transactions_list.dart';
import '../models/transaction.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      home: const MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.deepPurple,
          secondary: Colors.amber,
          error: Colors.redAccent,
        ),
        textTheme: tema.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelLarge: const TextStyle(color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _transactions
        .where(
          (tr) => tr.data.isAfter(
            DateTime.now().subtract(const Duration(days: 7)),
          ),
        )
        .toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      data: date,
    );

    setState(
      () {
        _transactions.add(newTransaction);
      },
    );
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text(
        'Finanças',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
    );
    final availabelHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Exibir gráfico'),
                Switch(value: _showChart, onChanged: (value) {
                  setState(() {
                    _showChart = value;
                  });
                }),
              ],
            ),
            if(_showChart || !isLandscape)
            SizedBox(
              height: availabelHeight * (isLandscape ? 0.7 : 0.3),
              child: Chart(_recentTransaction),
            ),
            if(!_showChart || !isLandscape)
            SizedBox(
              height: availabelHeight * 0.7,
              child: TransactionList(_transactions, _removeTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
