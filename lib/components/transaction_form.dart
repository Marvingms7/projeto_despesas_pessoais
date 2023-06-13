import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_despesas_pessoais/components/adaptative_button.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }

        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titulo'),
                onSubmitted: (_) => _submitForm(),
              ),
              TextField(
                controller: _valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Valor R\$'),
                onSubmitted: (_) => _submitForm(),
              ),
              Row(
                children: [
                  // ignore: unnecessary_null_comparison
                  Expanded(
                    child: Text(
                      // ignore: unnecessary_null_comparison
                      _selectedDate == null
                          ? 'Nenhuma data selecionada'
                          : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    style: TextButton.styleFrom(
                        side: const BorderSide(style: BorderStyle.none)),
                    child: const Text('Selecionar Data'),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton('Nova transanção', _submitForm),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
