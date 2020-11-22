import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  final _transactions = [
    Transaction(
        id: 't1',
        title: 'Novo Tênis de corrida',
        value: 310.86,
        date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Conta de Luz', value: 200.00, date: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Card(
              child: Text('Gráfico'),
              color: Colors.blue,
            ),
          ),
          Column(
            children: _transactions.map((tr) {
              return Card(
                child: Row(children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.purple[100],
                      width: 2,
                    )),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      tr.value.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple),
                    ),
                  ),
                  Column(
                    children: [Text(tr.title), Text(tr.date.toString())],
                  )
                ]),
                elevation: 4,
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
