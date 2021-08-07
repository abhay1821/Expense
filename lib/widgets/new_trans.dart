import 'package:flutter/material.dart';

class NewTrans extends StatelessWidget {
  final Function addTx;
  // String titleInput;
  // String amountInput;
  //used for user entered values
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  //here we got the new trans pointer address
  NewTrans(this.addTx);

  void submitdata() {
    final enteredTitle = titleController.text;
    final enteredamount = double.parse(titleController.text);
    if (enteredTitle.isEmpty || enteredamount <= 0) {
      return;
    }
    addTx(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitdata,
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
    );
  }
}
