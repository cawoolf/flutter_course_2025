import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(expense.title, style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: 4),
              Row(
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}'),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category]),
                      const SizedBox(width: 8.0),
                      Text(expense.formattedDate)
                    ],
                  )
                ],
              )
            ],
          ),
    ));
  }
}

/*
Notes
Card() widget is good for styling
.toStringAsFixed() ensure that a double is only displayed up to the int digit
Spacer() widget takes up all space available to it. Used to Left and Right justify widgets in a Row()


*/
