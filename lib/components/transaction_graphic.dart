import 'package:expenses/components/transaction_chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionGraphic extends StatelessWidget {
  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      recentTransaction.forEach((element) {
        if (element.date.day == weekDay.day) {
          totalSum += element.value;
        }
      });

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    });
  }

  totalSumDay(recentTransaction) {}

  TransactionGraphic(this.recentTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: groupedTransactions.map((e) {
          return TransactionChartBar(
            day: e['day'],
            value: e['value'],
            percentage: 0.00,
          );
        }).toList(),
      ),
      elevation: 6,
      margin: EdgeInsets.all(20),
    );
  }
}
