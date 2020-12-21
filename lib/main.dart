import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:io';
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

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

  openTransactionFormModal(BuildContext context, bool isLandscape) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  closeTransactionFormModal() {
    Navigator.of((context)).pop();
  }

  Widget _getIconButton(IconData icon, Function fn) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Platform.isIOS
          ? GestureDetector(
              onTap: fn,
              child: Icon(icon),
            )
          : IconButton(icon: Icon(icon), onPressed: fn),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final titleApp = Text(
      'Despesas Pessoais',
      style: TextStyle(fontSize: 20 * mediaQuery.textScaleFactor),
    );

    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final actions = [
      if (isLandscape)
        _getIconButton(
            _showChart
                ? (Platform.isIOS ? Icons.list : CupertinoIcons.list_bullet)
                : (Platform.isIOS
                    ? CupertinoIcons.chart_bar
                    : Icons.show_chart),
            () => setState(() {
                  _showChart = !_showChart;
                })),
      _getIconButton(
          Platform.isIOS ? CupertinoIcons.add_circled_solid : Icons.add,
          () => openTransactionFormModal(context, isLandscape)),
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: titleApp,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(title: titleApp, actions: actions);

    final double availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
        child: SingleChildScrollView(
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
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyPage,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => openTransactionFormModal(context, isLandscape),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
