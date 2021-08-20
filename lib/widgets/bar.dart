import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final String label;
  final double spendingamount;
  final double spendingperc;

  Bar(this.label, this.spendingamount, this.spendingperc);

  @override
  Widget build(BuildContext context) {
    //for dynamically allocating the height of device
    // using constraints as a object of elemnts inside
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            //for decimal places asfixed
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text('₹${spendingamount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              //3 ate
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
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.05,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
