import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(this.label, this.value, this.percentage, {Key? key})
      : super(key: key);
  final String label;
  final double value;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
