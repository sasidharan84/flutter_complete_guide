import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _addTransaction() {
    if (_titleController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        _selectedDate != null) {
      widget.addTransaction(_titleController.text,
          double.parse(_amountController.text), _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _selectTransactionDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _addTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: false),
              onSubmitted: (_) => _addTransaction(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(_selectedDate == null
                          ? 'Choose a Date!'
                          : DateFormat.yMd().format(_selectedDate))),
                  FlatButton(
                      onPressed: _selectTransactionDate,
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _addTransaction,
            )
          ],
        ),
      ),
    );
  }
}
