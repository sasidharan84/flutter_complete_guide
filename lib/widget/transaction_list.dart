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
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        child: Text(
                          "\$${userTransactions[index].amount.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                        ),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userTransactions[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            DateFormat("yyyy-MM-dd hh:mm:ss aa")
                                .format(userTransactions[index].date),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: userTransactions.length,
            ),
    );
  }
}
