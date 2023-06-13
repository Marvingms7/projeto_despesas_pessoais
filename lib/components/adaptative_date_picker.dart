import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AdaptativeDatePicker extends StatelessWidget {
  const AdaptativeDatePicker(
      {super.key, required this.selectedDate, required this.onDateChange});

  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  _showDatePicker(BuildContext context) {
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
        onDateChange(pickedDate);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChange,
            ),
          )
        : Row(
            children: [
              // ignore: unnecessary_null_comparison
              Expanded(
                child: Text(
                  // ignore: unnecessary_null_comparison
                  selectedDate == null
                      ? 'Nenhuma data selecionada'
                      : 'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}',
                ),
              ),
              TextButton(
                onPressed: () => _showDatePicker(context),
                style: TextButton.styleFrom(
                    side: const BorderSide(style: BorderStyle.none)),
                child: const Text('Selecionar Data'),
              )
            ],
          );
  }
}
