import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('💸${spendingAmount.toStringAsFixed(0)}'))),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.60,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(child: Text(label))),
          ],
        );
      },
    );
  }
}
