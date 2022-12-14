import 'package:expenses_counter/models/transaction.dart';
import 'package:expenses_counter/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index),);

      var totalSum = 0.0;

      for(var i=0; i<recentTransaction.length; i++){
        if(recentTransaction[i].date.day == weekDay.day &&
        recentTransaction[i].date.month == weekDay.month &&
        recentTransaction[i].date.year == weekDay.year){

          totalSum += recentTransaction[i].amount;

        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {'day': DateFormat.E().format(weekDay).substring(0, 1), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValue.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValue);
    return Container(
      // height: MediaQuery.of(context).size.height * 0.4,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValue.map((data){
              return Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: ChartBar(
                  data['day'].toString(),
                  data['amount'] as double,
                  totalSpending == 0.0 ? 0.0 :(data['amount']as double)/ totalSpending,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}