import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final valueController = TextEditingController();
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(labelText: 'Valor R\$'),
            ),
            ElevatedButton(
              onPressed: () {
                print(titleController.text);
                print(valueController.text);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)))),
              child: const Text('Nova Transação'),
            ),
          ],
        ),
      ),
    );
  }
}
