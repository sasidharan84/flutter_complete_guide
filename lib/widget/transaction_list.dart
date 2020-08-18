import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/model/transaction.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function removeTransaction;

  TransactionList({@required this.userTransactions, this.removeTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: userTransactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * .1,
                    child: Text(
                      'No transaction entered yet',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * .1,
                  ),
                  Container(
                    child: Image.asset('assets/images/waiting.png'),
                    height: constraints.maxHeight * .8,
                  )
                ],
              );
            })
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
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              removeTransaction(userTransactions[index].id)),
                    ));
              },
              itemCount: userTransactions.length,
            ),
    );
  }
}
