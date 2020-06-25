import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;

  NewTransaction(this.newTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInput = TextEditingController();

  final priceInput = TextEditingController();
  DateTime date;
  var showPrice = false;
  void setPrice() {
    setState(() {
      showPrice = true;
    });
  }

  void onSubmit() {
    if (titleInput.text.isEmpty || priceInput.text.isEmpty || date == null) {
      return;
    }

    widget.newTx(titleInput.text, double.parse(priceInput.text), date);
  }

  void openCalender() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        date = value;
      });
    });
  }

  final container = Container(
    width: 1,
    height: 1,
  );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              left: 10,
              right: 10,
              top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                onTap: setPrice,
                controller: titleInput,
                decoration: InputDecoration(labelText: 'Title'),
                onSubmitted: (val) => onSubmit(),
              ),
              showPrice
                  ? TextField(
                      keyboardType: TextInputType.number,
                      controller: priceInput,
                      decoration: InputDecoration(labelText: 'Price'),
                      onSubmitted: (val) => onSubmit(),
                    )
                  : container,
              SizedBox(
                height: 20,
              ),
              showPrice
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          date == null
                              ? 'Please Choose Date'
                              : 'Picked Date:${DateFormat.yMMMd().format(date)}',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 18),
                        ),
                        FlatButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: openCalender,
                          child: Text(
                            'Open Calender',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )
                  : container,
              showPrice
                  ? IconButton(
                      color: Theme.of(context).primaryColor,
                      iconSize: 50,
                      alignment: Alignment.centerRight,
                      onPressed: onSubmit,
                      icon: Icon(Icons.add_circle),
                    )
                  : container,
            ],
          ),
        ),
      ),
    );
  }
}
