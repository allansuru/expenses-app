import 'package:expenses/components/transaction_list-item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(Transaction transaction) onDelete;

  const TransactionList(
    this.transactions,
    this.onDelete,
  );

  Future<void> _showDeleteDialog(context, transaction) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 4,
          title: const Text('Deletar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja deletar o item abaixo?'),
                Text(
                  transaction.title,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Deletar'),
              onPressed: () {
                deleteHandler(context, transaction);
              },
            ),
            TextButton(
              child: Text('voltar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  deleteHandler(context, transaction) {
    Navigator.of(context).pop();
    return onDelete(transaction);
  }

  @override
  Widget build(BuildContext context) => transactions.isEmpty
      ? LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.1),
                Text(
                  'Nenhuma Transação Cadastrada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: constraints.maxHeight * 0.1),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            );
          },
        )
      : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            final tr = transactions[index];
            return TransactionListItem(
                transaction: tr, showDeleteDialog: _showDeleteDialog);
          });
}
