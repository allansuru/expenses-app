import 'package:flutter/material.dart';

class TransactionChartBar extends StatelessWidget {
  final String day;
  final double value;
  final double percentage;
  TransactionChartBar({this.day, this.value, this.percentage});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('R\$${value.toStringAsFixed(2)}'),
        SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: null,
        ),
        SizedBox(height: 5),
        Text(day),
      ],
    );
  }
}
