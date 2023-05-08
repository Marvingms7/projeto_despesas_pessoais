import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {required this.label,
      required this.value,
      required this.percentage,
      Key? key})
      : super(key: key);
  final String label;
  final double value;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('R\$${value.toStringAsFixed(2)}'),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                )),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(label)
      ],
    );
  }
}
