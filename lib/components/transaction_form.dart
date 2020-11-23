import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  submitForm() {
    final String title = titleController.text;
    final double value = double.tryParse(valueController.text ?? 0.0);

    if (title.isEmpty || value <= 0.0) {
      return;
    }

    onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) => Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                onSubmitted: (_) => submitForm(),
                controller: titleController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitForm(),
                controller: valueController,
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      textColor: Colors.purple,
                      onPressed: () => submitForm(),
                      child: Text('Nova Transação')),
                ],
              )
            ],
          ),
        ),
      );
}
