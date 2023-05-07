import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransaction});

  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSun = 0.0;

      for(var i = 0; i < recentTransaction.length; i++){
        bool sameDay = recentTransaction[i].data.day == weekDay.day;
        bool sameMonth = recentTransaction[i].data.month == weekDay.month;
        bool sameYear = recentTransaction[i].data.year == weekDay.year;
        if(sameDay && sameMonth && sameYear){
          totalSun += recentTransaction[i].value;
        }
      }



      print(DateFormat.E().format(weekDay)[0]);
      print(totalSun);


      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSun,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return const Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
    );
  }
}
