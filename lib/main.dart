import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';

import 'dart:math';
import 'package:expenses/models/transaction.dart';

import 'components/transaction_graphic.dart';
import 'components/transaction_list.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'Novo Tênis de corrida',
        value: 310.86,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: 't2',
        title: 'Conta de Luz',
        value: 200.40,
        date: DateTime.now().subtract(Duration(days: 30))),
    Transaction(
        id: 't2',
        title: 'Conta de Luz',
        value: 200.40,
        date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(
        id: 't3',
        title: 'Fatura do Cartão de crédito',
        value: 1500,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(id: 't4', title: 'Ubber', value: 99, date: DateTime.now()),
  ];

  addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });

    closeTransactionFormModal();
  }

  List<Transaction> get _lastSevenTransactions {
    return _transactions
        .where((element) =>
            DateTime.now().subtract(Duration(days: 7)).isBefore(element.date))
        .toList();
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
            TransactionGraphic(_lastSevenTransactions),
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
