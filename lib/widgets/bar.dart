import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final String label;
  final double spendingamount;
  final double spendingperc;

  Bar(this.label, this.spendingamount, this.spendingperc);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //for decimal places asfixed
        Container(
          height: 20,
          child: FittedBox(
            child: Text('₹${spendingamount.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingperc,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
