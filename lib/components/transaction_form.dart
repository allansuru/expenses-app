import 'package:flutter/material.dart';
import 'adaptative_button.dart';
import 'adaptative_date_picker.dart';
import 'adaptative_textField.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit) {
    print('Constructor TransactionForm');
  }

  @override
  _TransactionFormState createState() {
    print('createState TransactionForm');

    return _TransactionFormState();
  }
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _TransactionFormState() {
    print('Constructor _TransactionFormState');
  }

  @override
  void initState() {
    super.initState();
    print('initState _TransactionFormState');
  }

  @override
  void didUpdateWidget(TransactionForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget _TransactionFormState');
  }

  void dispose() {
    super.dispose();
    print('dispose _TransactionFormState');
  }

  _submitForm() {
    final String title = _titleController.text;
    final double value = double.tryParse(_valueController.text ?? 0.0);

    if (title.isEmpty || value <= 0.0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  onDateChanged(newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10,
            ),
            child: Column(
              children: [
                AdaptativeTextField(
                  controller: _titleController,
                  title: 'Título',
                  submit: _submitForm(),
                  isNumeric: false,
                ),
                AdaptativeTextField(
                  controller: _valueController,
                  title: 'Valor (R\$)',
                  submit: _submitForm(),
                  isNumeric: true,
                ),
                AdaptativeDatePicker(
                    selectedDate: _selectedDate, onDateChanged: onDateChanged),
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
      );
}
