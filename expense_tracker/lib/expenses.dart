import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

import 'models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  //Dummy Data
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Gym Membership',
        amount: 95.99,
        date: DateTime(2025, 3, 1),
        category: Category.leisure),
    Expense(
        title: 'Sushi',
        amount: 19.99,
        date: DateTime(2025, 2, 28),
        category: Category.work),
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Gym Membership',
        amount: 95.99,
        date: DateTime(2025, 3, 1),
        category: Category.leisure),
    Expense(
        title: 'Sushi',
        amount: 19.99,
        date: DateTime(2025, 2, 28),
        category: Category.work)
  ];

  // final List<Expense> _registeredExpenses = [];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true, // Ensure widgets stay away from device features
        isScrollControlled: true,
        // Causes the overlay to take up the full screen
        context: context,
        builder: (ctx) => NewExpense(
            onAddExpense:
                _addExpense)); //ctx is the context related to the builder widget
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    // ScaffoldMessenger shows overlays at the root Scaffold()
    _triggerSnackBar(expenseIndex, expense);
  }

  void _triggerSnackBar(int expenseIndex, Expense expense) {
    // ScaffoldMessenger shows overlays at the root Scaffold()
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense deleted.'),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);

    double width =
        MediaQuery.of(context).size.width; // Used for creating Response layouts

    Widget mainContent = Center(
      child: Text('No expenses found. Start adding some!'), // Default Content
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Expense Tracker'),
          actions: [
            IconButton(
                icon: const Icon(Icons.add), onPressed: _openAddExpenseOverlay)
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent)
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  // Expanded constrains the child to only take as much width as available in the Row, after sizing the other Row children
                  Expanded(child: mainContent)
                ],
              ));
  }
}

/*
Notes

Column() inside of Column() usually needs the Expanded() widget. Flutter won't know how to size it correctly otherwise.
context is provided automatically in a Widget that extends State
Every widget has a context object
context contains Widget meta data, and information about it's location in the Widget tree

Scaffold constrains widgets to max device height and width. Good for the root parent widget.
Scaffold is also automatically inside a SafeArea. Stays away from device features.

 */
