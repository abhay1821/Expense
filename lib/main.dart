import '/widgets/new_trans.dart';
import 'package:flutter/material.dart';
import './widgets/tran_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      amount: 6969,
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
      print(_userTransaction.length);
    });
    Navigator.pop(context);
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return
            //is used so that modal does not close down on just clicking on sheet
            NewTrans(_addnewTrans);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('CHART !'),
                elevation: 5,
              ),
            ),
            TranList(_userTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //due to modal method
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
