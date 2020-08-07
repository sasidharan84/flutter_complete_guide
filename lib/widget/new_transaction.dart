import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  final dateController = TextEditingController();

  void _addTransaction() {
    if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
      widget.addTransaction(titleController.text,
          double.parse(amountController.text), DateTime.now());
      Navigator.of(context).pop();
    }
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
              controller: titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _addTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: false),
              onSubmitted: (_) => _addTransaction(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(
                    'Choose a Date!',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  FlatButton(
                      onPressed: null,
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
              textColor: Colors.purple,
              onPressed: _addTransaction,
            )
          ],
        ),
      ),
    );
  }
}
