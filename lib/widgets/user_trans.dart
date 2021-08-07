import 'package:flutter/material.dart';
import './new_trans.dart';
import './tran_list.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 'T1',
      title: 'New SHOES',
      amount: 69.69,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T2',
      title: 'Laptop',
      amount: 76969,
      date: DateTime.now(),
    ),
  ];

  void _addnewTrans(String txtitle, double txamount) {
    final newtx = Transaction(
      title: txtitle,
      amount: txamount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    //setstate to update widget
    //we cant use usertran=... that will voilate
    //since dart just stores address pf the objects in memory
    //so with add we can manipulate the hardcoded value or anything
    setState(() {
      _userTransaction.add(newtx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //_addnewtrans passes the pointer for new trans can be updated
        // as soon as the button is pressed
        NewTrans(_addnewTrans),
        TranList(_userTransaction),
      ],
    );
  }
}
