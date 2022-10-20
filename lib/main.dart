import 'package:expenses_counter/widgets/chart.dart';
import 'package:expenses_counter/widgets/new_transaction.dart';
import 'package:expenses_counter/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/transaction.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
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
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        accentColor: Colors.amber,
        errorColor: Colors.redAccent,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              caption: const TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              button: const TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
            toolbarTextStyle: ThemeData.light()
                .textTheme
                .copyWith(
                  subtitle1: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .bodyText2,
            titleTextStyle: ThemeData.light()
                .textTheme
                .copyWith(
                  subtitle1: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .headline6),
      ),
      home: const MyHomePage(title: 'Personal Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      // date:DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deletTransection(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _startProcessAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            _startProcessAddNewTransaction(context);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
    final listWidget = Container(
        height: (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deletTransection));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // top to bottom
          // crossAxisAlignment: CrossAxisAlignment.start, //left to right
          children: <Widget>[
            if(isLandScape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Show CHART!',
                  // style: Theme.of(context).textTheme.caption,
                ),
                Switch(value: _showChart, onChanged: (val){
                  setState(() {
                    _showChart = val;
                  });
                },),
              ],
            ),
            if(!isLandScape) Container(
                height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                    0.3,
                // 0.3,
                child: Chart(_recentTransactions)),
            if(!isLandScape) listWidget,
            if(isLandScape)_showChart ? Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                    // 0.3,
                child: Chart(_recentTransactions))
            :listWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.yellow,
        onPressed: () {
          _startProcessAddNewTransaction(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
