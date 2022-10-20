import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Transaction Added yet!',
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        deleteTx(transactions[index].id);
                      },
                    ),
                  ),
                );
                // return Card(
                //   child: Row(children: <Widget>[
                //     Container(
                //       margin: const EdgeInsets.symmetric(
                //         vertical: 10,
                //         horizontal: 15,
                //       ),
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: Theme.of(context).primaryColor,
                //           // color: Colors.red,
                //           width: 2,
                //         ),
                //       ),
                //       padding: const EdgeInsets.all(10),
                //       child: Text(
                //         '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                //         style: const TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 20,
                //           color: Colors.red,
                //         ),
                //       ),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: <Widget>[
                //         Text(
                //           transactions[index].title,
                //           style: Theme.of(context).textTheme.caption,
                //         ),
                //         Text(
                //           DateFormat.yMMMd().format(transactions[index].date),//tx.date.toString(),//'yyyy/MM/dd'
                //           style: const TextStyle(
                //             color: Colors.grey,
                //           ),
                //         )
                //       ],
                //     ),
                //   ],
                //   ),
                //   // child: Text(tx.title),
                // );
              },
              itemCount: transactions.length,
              // children: transactions.map((tx){
              //
              // }).toList(),
            ),
    );
  }
}
