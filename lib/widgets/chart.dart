import 'dart:core';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1).toUpperCase(),
        'amount': totalSum
      };
    });
  }

  double get totalSpeding {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Card(
          elevation: 6,
          margin: EdgeInsets.all(20),
          child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: groupedTransactionValues.map((data) {
                  return Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: ChartBar(
                          data['day'],
                          data['amount'],
                          totalSpeding == 0.0
                              ? 0.0
                              : (data['amount'] as double) / totalSpeding));
                }).toList(),
              )),
        ));
  }
}
