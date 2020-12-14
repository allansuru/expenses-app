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
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  _addTransaction(String title, double value, DateTime date) {
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

  _deleteTransaction(Transaction transaction) {
    setState(() {
      _transactions.removeWhere((element) => element.id == transaction.id);
    });
  }

  openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  closeTransactionFormModal() {
    Navigator.of((context)).pop();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    AppBar appBar = mountAppBar(context, isLandscape);
    double availableHeight = _availableHeight(context, appBar);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!isLandscape)
              Container(
                  height: availableHeight * 0.4,
                  child: TransactionGraphic(_lastSevenTransactions)),
            if (!isLandscape)
              Container(
                  height: availableHeight * 0.6,
                  child: TransactionList(_transactions, _deleteTransaction)),
            if (isLandscape)
              _showChart
                  ? Container(
                      height: availableHeight * 0.6,
                      child: TransactionList(_transactions, _deleteTransaction))
                  : Container(
                      height: availableHeight * (isLandscape ? 0.8 : 0.4),
                      child: TransactionGraphic(_lastSevenTransactions)),
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

  AppBar mountAppBar(BuildContext context, bool isLandscape) {
    return AppBar(
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(fontSize: 20 * MediaQuery.of(context).textScaleFactor),
      ),
      actions: [
        if (isLandscape)
          IconButton(
              icon: Icon(_showChart ? Icons.list : Icons.show_chart),
              onPressed: () => setState(() {
                    _showChart = !_showChart;
                  })),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => openTransactionFormModal(context)),
      ],
    );
  }

  double _availableHeight(BuildContext context, AppBar appBar) {
    return MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
  }
}
