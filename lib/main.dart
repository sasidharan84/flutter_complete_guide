import 'package:flutter/material.dart';
import 'widget/chart.dart';
import 'widget/new_transaction.dart';

import 'model/transaction.dart';
import 'widget/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Opensans',
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.white,
                ),
                headline5: TextStyle(
                  fontFamily: 'Opensans',
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _popupAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bdctx) {
        return NewTransaction(
          addTransaction: _addTransaction,
        );
      },
    );
  }

  final List<Transaction> _userTransactions = [
    //Transaction(id: "t1", title: "Book", amount: 50.50, date: DateTime.now()),
    //Transaction(id: "t2", title: "Coffee", amount: 4.50, date: DateTime.now())
  ];

  void _addTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Flutter App"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _popupAddNewTransaction(context);
          },
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.4,
            child: Chart(
                recentTransactions: _userTransactions
                    .where((element) =>
                        DateTime.now().difference(element.date).inDays < 7)
                    .toList()),
          ),
          Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.6,
            child: TransactionList(
              userTransactions: _userTransactions,
              removeTransaction: _removeTransaction,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _popupAddNewTransaction(context);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
