import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
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

  Widget _getIconsButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            icon: Icon(icon),
            onPressed: fn,
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;


    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final chartList = Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = [
      if (isLandscape)
        _getIconsButton(
          _showChart ? iconList : chartList,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconsButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];
    final appBar = AppBar(
      title: const Text(
        'Finanças',
        style: TextStyle(color: Colors.white),
      ),
      actions: actions,
    );
    final availabelHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_showChart || !isLandscape)
            SizedBox(
              height: availabelHeight * (isLandscape ? 0.7 : 0.3),
              child: Chart(_recentTransaction),
            ),
          if (!_showChart || !isLandscape)
            SizedBox(
              height: availabelHeight * (isLandscape ? 1 : 0.7),
              child: TransactionList(_transactions, _removeTransaction),
            ),
        ],
      ),
    ),
    );
    
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Finanças'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _openTransactionFormModal(context),
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
