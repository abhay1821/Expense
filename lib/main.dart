import 'dart:io';
import 'package:flutter/services.dart';
import '/widgets/new_trans.dart';
import 'package:flutter/material.dart';
import './widgets/tran_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  //for setting orientaion for the app
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
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
  final List<Transaction> _userTransaction = [];
  List<Transaction> get _recenttransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addnewTrans(String txtitle, double txamount, DateTime choosendate) {
    final newtx = Transaction(
      title: txtitle,
      amount: txamount,
      date: choosendate,
      id: DateTime.now().toString(),
    );

    //setstate to update widget
    //we cant use usertran=... that will voilate
    //since dart just stores address pf the objects in memory
    //so with add we can manipulate the hardcoded value or anything
    setState(() {
      _userTransaction.add(newtx);
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

  void _deletetransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expense'),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              //dynamically allocating the size of device
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(_recenttransaction),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TranList(_userTransaction, _deletetransaction),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //since floatingaction button does not work on IOS
      //so we can chck through it
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              //due to modal method
              onPressed: () => _startAddNewTransaction(context),
            ),
    );
  }
}
