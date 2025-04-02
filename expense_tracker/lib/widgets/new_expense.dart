import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart' as expense;
import 'dart:io';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(expense.Expense expense)
      onAddExpense; // Dependency injection with setState. Uses a callback to Expenses()

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  expense.Category _selectedCategory = expense.Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    // This line of code executes after the Future value is returned from await
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController
        .text); //tryParse("Hello") => null, tryParse('1.12') => 1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount < 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog(); // show error msg
      return; // Returns to prevent the rest of the _submitExpenseData from executing due to an error
    }

    // Call back to Expense() to add an Expense to the list
    widget.onAddExpense(expense.Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));

    Navigator.pop(context); // Closes the model after adding an expense
  }

  // Displays alert dialog style based on iOS or Android
  void _showDialog() {
    if(Platform.isIOS) {
      _showCupertinoDialogIOS();
    } else {
      _showMaterialAlertDialog();
    }
  }

  void _showCupertinoDialogIOS() {
    showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date, and category was entered.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ));
  }

  void _showMaterialAlertDialog() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Invalid Input'),
              content: const Text(
                  'Please make sure a valid title, amount, date, and category was entered.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'))
              ],
            ));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
  //
  //   return SizedBox(
  //     height: double.infinity,
  //     child: SingleChildScrollView(
  //       child: Padding(
  //           padding: EdgeInsets.fromLTRB(16,48,16,keyboardSpace + 16),
  //           child: Column(
  //             children: [
  //               _titleField(),
  //            _amountRow(),
  //               SizedBox(height: 32.0),
  //               _bottomRow(context)
  //             ],
  //           )),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      print(constraints.minWidth);
      print(constraints.maxWidth);
      print(constraints.minHeight);
      print(constraints.maxWidth);

      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Expanded(child: _titleField()),
                      SizedBox(width: 24),
                      Expanded(child: _amountTextField())
                    ])
                  else
                    _titleField(),
                    // _amountRow(),
                    // SizedBox(height: 32.0),
                  _bottomRow(context)
                ],
              )),
        ),
      );
    });
  }

  TextField _titleField() {
    return TextField(
      controller: _titleController,
      keyboardType: TextInputType.text,
      maxLength: 50,
      decoration: InputDecoration(label: Text('Title')),
    );
  }

  Row _bottomRow(BuildContext context) {
    return Row(
      children: [
        DropdownButton(
            value: _selectedCategory,
            items: expense.Category.values
                .map((category) => DropdownMenuItem(
                    value: category, child: Text(category.name.toUpperCase())))
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              setState(() {
                _selectedCategory = value;
              });
            }),
        SizedBox(width: 24.0),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Pops the model off the stack
            },
            child: Text('Cancel')),
        SizedBox(width: 24.0),
        ElevatedButton(
            onPressed: () {
              // print(_titleController.text);
              // print(_amountController.text);
              _submitExpenseData();
            },
            child: const Text('Save Expense'))
      ],
    );
  }

  TextField _amountTextField() {
    return TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration:
                InputDecoration(prefixText: '\$ ', label: Text('Amount')),
          );
  }

  Expanded _datePicker() {
    return Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_selectedDate == null
              ? 'No date selected'
              : formatter.format(_selectedDate!)),
          IconButton(
              onPressed: _presentDatePicker,
              icon: const Icon(Icons.calendar_month))
        ],
      ));
  }
}

/*
Notes

TextField() widget is used for Text inputs. Lots of different formatting options
onChanged in the TextField() is called on every ket stroke
Controllers() are very useful for managing inputs. Can store and display values.
Always call dispose() on all controllers. Can live on in memory after the widget is destroyed
 */
