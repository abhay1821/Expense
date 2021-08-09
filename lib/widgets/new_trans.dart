import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedate = DateTime.now();

  void _submitdata() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredamount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredamount <= 0 || _selectedate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredamount,
      _selectedate,
    );
  }

  void _datepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        _selectedate = pickedData;
      });
    });
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
                controller: _titleController,
                onSubmitted: (_) => _submitdata,
                //for direct next line
                textInputAction: TextInputAction.next,
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (val) => amountInput = val,
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitdata,
                textInputAction: TextInputAction.done,
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text(
                      _selectedate == null
                          ? 'NO DATE CHOOSEN'
                          : DateFormat.yMd().format(_selectedate),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: _datepicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: _submitdata,
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
