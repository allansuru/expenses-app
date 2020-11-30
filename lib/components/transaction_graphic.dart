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

  double get weekTotalValue {
    return groupedTransactions.fold(0, (acc, item) => acc + item['value']);
  }

  totalSumDay(recentTransaction) {}

  TransactionGraphic(this.recentTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: TransactionChartBar(
                day: e['day'],
                value: e['value'],
                percentage: (e['value'] as double) / weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
