import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String, double) onSubmit;

  @override
  Widget build(BuildContext context) {
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
                final title = titleController.text;
                final value = double.tryParse(valueController.text) ?? 0.0;
                onSubmit(title, value);
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
