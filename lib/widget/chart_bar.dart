import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double perentageSpent;

  ChartBar({this.label, this.amountSpent, this.perentageSpent});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * .15,
            child: FittedBox(
              child: Text('\$${amountSpent.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * .05,
          ),
          Container(
            height: constraints.maxHeight * .6,
            width: constraints.maxWidth * .2,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: perentageSpent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * .05,
          ),
          Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(child: Text(label)))
        ],
      );
    });
  }
}
