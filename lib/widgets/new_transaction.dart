import '../models/transection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatelessWidget {
  late String titleInput;
  late String amountInput;

  final Function addTx;
  final titleControle = TextEditingController();
  final amountControle = TextEditingController();

  NewTransaction(this.addTx);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child:Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Title',
              ),
              controller: titleControle,
              onChanged: (value){
                titleInput = value;

              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountControle,
              onChanged: (value){
                amountInput = value;
              },
            ),
            FlatButton(
                onPressed: (){
                  // print(titleControle.text);
                  // print(amountInput);

                  addTx(titleControle.text, double.parse(amountControle.text));
                  // titleControle.clear();
                  // amountControle.clear();

                },
                textColor: Colors.purple,
                child: Text('Add Transaction'))
          ],
        ),
      ),
    );
  }
}