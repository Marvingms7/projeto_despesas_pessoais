import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'transaction_form.dart';
import 'transactions_list.dart';

import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  @override
  Widget build(BuildContext context) {
    late final List<Transaction> _transactions = [
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
    return Column(
      children: [
        TransactionList(_transactions.cast<TransactionList>()),
        TransactionForm(),
      ],
    );
  }
}
