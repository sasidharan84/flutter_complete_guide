import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/model/transaction.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  List<Map<String, Object>> get recentTransByDay {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.00;

      recentTransactions.forEach((element) {
        var transDate = element.date;

        if (transDate.day == weekday.day &&
            transDate.month == weekday.month &&
            transDate.year == weekday.year) {
          totalAmount += element.amount;
        }
      });

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();
  }

  double get TotalAmountSpent {
    var totalAmount = 0.0;

    recentTransactions.forEach((element) {
      totalAmount += element.amount;
    });

    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    print(recentTransactions);
    print(recentTransByDay);
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: recentTransByDay.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: e['day'],
                  amountSpent: e['amount'],
                  perentageSpent: TotalAmountSpent == 0.0
                      ? 0.0
                      : (e['amount'] as double) / TotalAmountSpent),
            );
          }).toList(),
        ),
      ),
    );
  }
}
