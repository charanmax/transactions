import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transactions/Models/transactions.dart';

class Entry extends StatelessWidget {
  final List<Transactions> transactions;
  final Function removeTransaction;
  final size;

  Entry(this.transactions, this.removeTransaction, this.size);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        child: transactions.length != 0
            ? ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    shadowColor: Colors.grey,
                    elevation: 5.0,
                    child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(10),
                        leading: CircleAvatar(
                          radius: 30,
//                      backgroundColor: Theme.of(context).primaryColor,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                              child: Text(
                                '💲${transactions[index].price}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          '${transactions[index].title}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            removeTransaction(index);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                        )),
                  );
                },
                itemCount: transactions.length,
              )
            : Container(
                height: size,
                child: Column(
                  children: <Widget>[
                    Text('No Transactions!Please add one.',
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: Image.asset(
                        "assets/images/zzz.png",
                      ),
                    ),
                  ],
                ),
              ));
  }
}
