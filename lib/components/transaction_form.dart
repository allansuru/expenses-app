import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptative_button.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final String title = _titleController.text;
    final double value = double.tryParse(_valueController.text ?? 0.0);

    if (title.isEmpty || value <= 0.0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() async {
    _selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now());

    setState(() {
      _selectedDate = _selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Column(
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, right: 10, left: 10, bottom: 15),
              child: Column(
                children: [
                  TextField(
                    onSubmitted: (_) => _submitForm(),
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Título'),
                  ),
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (_) => _submitForm(),
                    controller: _valueController,
                    decoration: InputDecoration(labelText: 'Valor (R\$)'),
                  ),
                  Container(
                    height: 21,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedDate == null
                                ? 'Nenhuma data selecionada!'
                                : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                          ),
                        ),
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          onPressed: _showDatePicker,
                          child: Text(
                            'Selecionar Data',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AdaptativeButton(
                          title: 'Nova Transação', onPressed: _submitForm)
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ));
}
