import 'package:flutter/material.dart';

class NewTrans extends StatefulWidget {
  final Function addTx;
  // String titleInput;
  // String amountInput;
  //used for user entered values

  NewTrans(this.addTx);

  @override
  _NewTransState createState() => _NewTransState();
}

class _NewTransState extends State<NewTrans> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitdata() {
    final enteredTitle = titleController.text;
    final enteredamount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredamount <= 0) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredamount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitdata,
                //for direct next line
                textInputAction: TextInputAction.next,
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (val) => amountInput = val,
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitdata,
                textInputAction: TextInputAction.done,
              ),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: submitdata,
                child: Text('Add Transaction'),
                textColor: Colors.purple,
              )
            ],
          ),
        ),
      ),
    );
  }
}
