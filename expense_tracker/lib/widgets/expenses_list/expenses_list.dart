import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;

  final List<Expense> expenses;

  Container _dismissGradient(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red,
            Colors.white,
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.symmetric(
          horizontal: Theme.of(context).cardTheme.margin!.horizontal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: _dismissGradient(context),   // Creates background effect on swipe
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]);
            },
            child: ExpenseItem(expenses[index])));
  }
}

/*Notes
ListView() is automatically scroller.
ListView.builder() creates lists dynamically.
builder() takes a function for itemBuilder
itemCount defines how many calls are to be made to itemBuilder. Passes the index value to itemBuilder
Main effect of this code is to only create items for the list when needed. Can significantly improve performance for long lists

key makes widgets uniquely identifiable. Most widgets don't have to worry about keys. Dismissible does to ensure correct data is deleted.

*/
