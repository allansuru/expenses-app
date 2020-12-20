import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: FittedBox(child: Text('R\$${tr.value}')),
                  ),
                ),
                title: Text(
                  tr.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                trailing: MediaQuery.of(context).size.width > 480
                    ? FlatButton.icon(
                        onPressed: () => _showDeleteDialog(context, tr),
                        icon: const Icon(Icons.delete),
                        label: const Text('Excluir'),
                        textColor: Theme.of(context).errorColor,
                      )
                    : IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => _showDeleteDialog(context, tr)),
              ),
            );
          });
}
