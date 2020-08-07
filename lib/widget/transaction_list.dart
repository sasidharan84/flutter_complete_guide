import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/model/transaction.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList({@required this.userTransactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: userTransactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transaction entered yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Image.asset('assets/images/waiting.png'),
                  height: 200,
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              "\$${userTransactions[index].amount.toStringAsFixed(2)}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        userTransactions[index].title,
                        style:
                            Theme.of(context).appBarTheme.textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat("yyyy-MM-dd hh:mm:ss aa")
                            .format(userTransactions[index].date),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ));
              },
              itemCount: userTransactions.length,
            ),
    );
  }
}
