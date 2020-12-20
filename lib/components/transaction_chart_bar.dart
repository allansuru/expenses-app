import 'package:flutter/material.dart';

class TransactionChartBar extends StatelessWidget {
  final String day;
  final double value;
  final double percentage;

  const TransactionChartBar({this.day, this.value, this.percentage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                  child: Text(
                '${value.toStringAsFixed(2)}',
              )),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.5,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.10,
              child: SizedBox(
                height: constraints.maxHeight * 0.10,
              ),
            ),
            Container(child: FittedBox(child: Text(day))),
          ],
        );
      },
    );
  }
}
