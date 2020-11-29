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

      print(DateFormat.E().format(weekDay)[0]);
      print(totalSum);

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    });
  }

  totalSumDay(recentTransaction) {}

  TransactionGraphic(this.recentTransaction);

  @override
  Widget build(BuildContext context) {
    print(groupedTransactions);
    return Card(
      child: Row(
        children: [
          Text('Gráfico'),
        ],
      ),
      color: Colors.blue,
      elevation: 6,
      margin: EdgeInsets.all(20),
    );
  }
}
