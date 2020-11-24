import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';

import 'dart:math';
import 'package:expenses/models/transaction.dart';

import 'components/transaction_list.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = [
    Transaction(
        id: 't1',
        title: 'Novo Tênis de corrida',
        value: 310.86,
        date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Conta de Luz', value: 200.40, date: DateTime.now()),
  ];

  addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });

    closeTransactionFormModal();
  }

  openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(addTransaction);
        });
  }

  closeTransactionFormModal() {
    Navigator.of((context)).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => openTransactionFormModal(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Card(
                child: Text('Gráfico'),
                color: Colors.blue,
              ),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
