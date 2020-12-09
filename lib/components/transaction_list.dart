import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(Transaction transaction) onDelete;

  TransactionList(
    this.transactions,
    this.onDelete,
  );

  Future<void> _showDeleteDialog(context, transaction) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletar'),
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
  Widget build(BuildContext context) => Container(
        height: 400,
        child: transactions.isEmpty
            ? Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Nenhuma Transação Cadastrada!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20),
                  Container(
                      height: 200,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover))
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final tr = transactions[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
                      trailing: IconButton(
                          icon: Icon(Icons.delete_forever),
                          onPressed: () => _showDeleteDialog(context, tr)),
                    ),
                  );
                }),
      );
}
