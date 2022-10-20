import '../widgets/transaction_list.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'new_transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransaction createState() => _UserTransaction();
}

class _UserTransaction extends State<UserTransaction>{
  // final List<Transaction> _userTransactions = [
  //   Transaction(
  //       id: 't1',
  //       title: 'New Shoes',
  //       amount: 69.99,
  //       date: DateTime.now()
  //   ),
  //   Transaction(
  //       id: 't2',
  //       title: 'Weekly Groceries',
  //       amount: 16.43,
  //       date: DateTime.now()
  //   ),
  // ];
  //
  // void _addNewTransaction(String txTitle, double txAmount){
  //   final newTx = Transaction(
  //       id:DateTime.now().toString(),
  //       title: txTitle,
  //       amount: txAmount,
  //       date:DateTime.now(),
  //   );
  //
  //   setState(() {
  //     _userTransactions.add(newTx);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // NewTransaction(_addNewTransaction),
        // TransactionList(_userTransactions),
      ],
    );
  }
}