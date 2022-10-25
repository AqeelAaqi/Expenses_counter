import 'package:expenses_counter/widgets/transactionItem.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.6,
      // height: 500,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No Transaction Added yet!',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            })
          : ListView(
              children: transactions
                  .map((tx) => TransactionItem(
                        key: ValueKey(tx.id),
                        transaction: tx,
                        deleteTx: deleteTx,
                      ))
                  .toList(),
            ),
      // : ListView.builder(
      //     itemBuilder: (context, index) {
      //       return TransactionItem(transaction: transactions[index], deleteTx: deleteTx);
      //     },
      //     itemCount: transactions.length,
      //   ),
    );
  }
}
