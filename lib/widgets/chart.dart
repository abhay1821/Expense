import 'package:expense/widgets/bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenttransaction;
  Chart(this.recenttransaction);

  List<Map<String, dynamic>> get grouptransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalsum = 0.0;
      for (var i = 0; i < recenttransaction.length; i++) {
        if (recenttransaction[i].date.day == weekDay.day &&
            recenttransaction[i].date.month == weekDay.month &&
            recenttransaction[i].date.year == weekDay.year) {
          totalsum += recenttransaction[i].amount;
        }
      }
      //shortcut for weekdays
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalsum,
      };
    }).reversed.toList();
  }

  double get totalspending {
    //fold convert the list to other form according to us
    return grouptransaction.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: grouptransaction.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: Bar(
                data['day'],
                data['amount'],
                totalspending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalspending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
