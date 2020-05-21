import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: ListView.builder(
          itemBuilder: (BuildContext ctx, int index) {
            return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              '\$${transactions[index].amount}',
                              style: TextStyle(fontSize: 15),
                            ),
                          ))),
                  title: Text(
                    transactions[index].title,
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: TextStyle(fontSize: 10),
                  ),
                  trailing: IconButton(icon: Icon(Icons.delete), color: Theme.of(context).errorColor, onPressed:() => deleteTx(transactions[index].id),),
                )
            );
          },
          itemCount: transactions.length,
        ));
  }
}
