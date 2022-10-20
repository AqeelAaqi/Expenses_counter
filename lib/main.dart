import 'package:expenses_counter/widgets/chart.dart';
import 'package:expenses_counter/widgets/new_transaction.dart';
import 'package:expenses_counter/widgets/transaction_list.dart';
import 'package:expenses_counter/widgets/user_transactions.dart';
import 'package:flutter/material.dart';
import 'models/transection.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red).copyWith(secondary: Colors.amber),
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              caption: TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 18,
                color: Colors.black,
                fontWeight:FontWeight.bold,
              )
          ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                          subtitle1: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 20,
                          fontWeight:FontWeight.bold,
                      )
              )
          ),
      ),
      home: const MyHomePage(title: 'Personal Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
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
  ];
  void _addNewTransaction(String txTitle, double txAmount){
    final newTx = Transaction(
      id:DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date:DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),
      ),);
    }).toList();
  }

  void _startProcessAddNewTransaction(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (_){
          return GestureDetector(
            onTap: (){},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );

        },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontFamily: 'OpenSans'),),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              _startProcessAddNewTransaction(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // top to bottom
          // crossAxisAlignment: CrossAxisAlignment.start, //left to right
          children: <Widget>[
            Text('CHART!', style: Theme.of(context).textTheme.caption,),
            Chart(
              _recentTransactions
            ),
            // UserTransaction(),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.yellow,
        onPressed: (){
          _startProcessAddNewTransaction(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
