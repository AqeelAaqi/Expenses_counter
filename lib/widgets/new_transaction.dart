import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = _titleControler.text;
    final enteredAmount = double.parse(_amountControler.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      _titleControler.text,
      double.parse(_amountControler.text),
      _selectedDate
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now()).then((pickedDate) {
          if(pickedDate != null){
            setState(() {
              _selectedDate = pickedDate;
            });
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter Title',
              ),
              controller: _titleControler,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _submitData,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountControler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(_selectedDate == null ? 'No Date Chosen!'
                    :'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}')),
                FlatButton(
                    onPressed: _presentDatePicker,
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Choose Date'))
              ],
            ),
            RaisedButton(
                onPressed: () {
                  _submitData();
                },
                textColor: Theme.of(context).textTheme.button?.color,
                color: Colors.red,
                child: const Text('Add Transaction'))
          ],
        ),
      ),
    );
  }
}
