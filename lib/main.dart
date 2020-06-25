import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:transactions/Widgets/Entry.dart';
import 'package:transactions/Widgets/Newtransaction.dart';
import 'package:transactions/Widgets/chart.dart';
import 'Models/transactions.dart';

void main() => {
//      WidgetsFlutterBinding.ensureInitialized(),
//      SystemChrome.setPreferredOrientations(

//          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]),
      runApp(TransactionsApp())
    };

class TransactionsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'QuickSand',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        fontFamily: 'Solway',
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transactions> transactions = [
//    Transactions(title: 'Rice', id: '1', price: 2800, date: DateTime.now()),
//    Transactions(title: 'Dal', id: '2', price: 280, date: DateTime.now())
  ];
  List<Transactions> get _recentTransactions {
    return transactions.where(
      (element) {
        return element.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  bool showChart = true;

  void addNewTransaction(String txtitle, double txprice, DateTime givenDate) {
    final newTx = Transactions(
      title: txtitle,
      price: txprice,
      date: givenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      transactions.add(newTx);
    });
    Navigator.of(context).pop();
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addNewTransaction);
        });
  }

  void deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    var appBar = AppBar(
      actions: <Widget>[
        IconButton(
          onPressed: () => startNewTransaction(context),
          color: Colors.black,
          icon: Icon(Icons.add_circle),
        )
      ],
      title: Text(
        'Transactions',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      elevation: 15,
      centerTitle: true,
    );
    var chartListSize = isLandscape == true
        ? (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7
        : (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3;
    var transactionsListSize = (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
        0.7;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          height: mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/asfalt-dark.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (isLandscape)
                  Row(
                    children: <Widget>[
                      Text('Show chart',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          )),
                      Switch.adaptive(
                        activeColor: Theme.of(context).primaryColor,
                        value: showChart,
                        onChanged: (val) {
                          setState(() {
                            showChart = val;
                          });
                        },
                      )
                    ],
                  ),
                if (isLandscape)
                  showChart
                      ? Chart(_recentTransactions, chartListSize)
                      : Entry(transactions, deleteTransaction,
                          transactionsListSize),
                if (!isLandscape) Chart(_recentTransactions, chartListSize),
                if (!isLandscape)
                  Entry(transactions, deleteTransaction, transactionsListSize),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Platform.isAndroid
            ? FloatingActionButton(
                onPressed: () => startNewTransaction(context),
                child: Icon(Icons.add),
              )
            : Container(
                height: 1,
              ),
      ),
    );
  }
}
