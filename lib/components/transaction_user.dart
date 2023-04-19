import 'package:flutter/material.dart';
import 'transaction_form.dart';
import 'transactions_list.dart';
import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({Key? key}) : super(key: key);

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transactions.cast<TransactionList>()),
        const TransactionForm(),
      ],
    );
  }
}
