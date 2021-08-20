import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TranList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteT;

  TranList(this.transactions, this.deleteT);
  @override
  Widget build(BuildContext context) {
    return //.map() to transform object to widget
        transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'NO Transaction Added',
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.title,
                    // ignore: deprecated_member_use
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/check.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            //used when list no is more
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    //2k
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      //trailing is the icon widget at right side
                      trailing: IconButton(
                        color: Theme.of(context).errorColor,
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteT(transactions[index].id),
                      ),
                    ),
                  );
                },
                //Creates a scrollable, linear array of widgets that are created on demand
                itemCount: transactions.length,
              );
  }
}
