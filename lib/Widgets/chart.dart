import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transactions/Models/transactions.dart';
import 'package:transactions/Widgets/ChartBar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactionValues;
  final size;
  Chart(this.recentTransactionValues, this.size);

  List<Map<String, Object>> get recentTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;
      for (var i = 0; i < recentTransactionValues.length; i++) {
        if (recentTransactionValues[i].date.day == weekDay.day &&
            recentTransactionValues[i].date.month == weekDay.month &&
            recentTransactionValues[i].date.year == weekDay.year) {
          totalSum += recentTransactionValues[i].price;
        }
      }

//
      return {
        'Day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalWeekSum {
    return recentTransactions.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: recentTransactions.map((data) {
            return ChartBar(
                data['Day'],
                data['amount'],
                totalWeekSum == 0
                    ? 0.0
                    : (data['amount'] as double) / totalWeekSum);
          }).toList(),
        ),
      ),
    );
  }
}
