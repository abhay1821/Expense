import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TranList extends StatelessWidget {
  final List<Transaction> transactions;
  TranList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return //.map() to transform object to widget
        Container(
      height: 500,
      //we can also use list view or singlechild scrollview instead of list view builder
      //but list view has infinite view so we can wrap under container and mention height
      //listview.builder view loads only what is visible
      //but we need to work with itembuilder not with container
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'NO Transaction Added',
                  // ignore: deprecated_member_use
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/check.jpg',
                      fit: BoxFit.cover,
                    )),
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
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text('${transactions[index].amount}'))),
                    ),
                    title: Text(
                      transactions[index].title,
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
