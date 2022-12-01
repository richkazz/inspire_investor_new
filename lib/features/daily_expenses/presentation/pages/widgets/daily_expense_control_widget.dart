
import 'package:flutter/material.dart';

import '../../../../../core/colors/app_color.dart';

class ExpensesControl extends StatefulWidget {
  const ExpensesControl({Key? key, required this.expenses}) : super(key: key);
  final Map<String, String> expenses;
  @override
  State<ExpensesControl> createState() => _ExpensesControlState();
}

class _ExpensesControlState extends State<ExpensesControl> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: expensesList(),
    );
  }

  List<Widget> expensesList() {
    List<Widget> item = [];
    widget.expenses.forEach((key, value) {
      item.addAll([
        SizedBox(
          height: 60,
          child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: EditExpenses(
                  expenses: widget.expenses,
                  expense: key,
                  cost: value,
                ),
              )),
        ),
        const SizedBox(height: 7),
      ]);
    });

    return item;
  }
}

class EditExpenses extends StatefulWidget {
  const EditExpenses({Key? key, required this.expense, required this.cost, required this.expenses})
      : super(key: key);
  final String expense;
  final String cost;
  final Map<String, String> expenses;
  @override
  State<EditExpenses> createState() => _EditExpensesState();
}

class _EditExpensesState extends State<EditExpenses> {
  final editExpenseController = TextEditingController();
  late FocusNode _focusNode;
  bool isEditingExpense = false;
  String cost = '';
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    cost = widget.cost;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        expensesDisplay(widget.expense, cost),
        SizedBox(
          width: 70,
          height: 30,
          child: ElevatedButton(
            onPressed: isEditingExpense ? onDone : onAdd,
            style: style,
            child: isEditingExpense ? const Text('DONE') : const Text('ADD'),
          ),
        )
      ],
    );
  }

  void onAdd() {
    setState(() {
      isEditingExpense = true;
    });
    _focusNode.requestFocus();
  }

  void onDone() {
    if(editExpenseController.text.isNotEmpty){
      cost = editExpenseController.text;
    }
    changeCost();
  }

  void onSubmitted(String str) {
    if(str.isNotEmpty){
      cost = str;
    }
    changeCost();
  }

  void changeCost(){
    widget.expenses[widget.expense] = cost;
    setState(() {
      isEditingExpense = false;
    });
    _focusNode.unfocus();
  }

  Widget expensesEdit() {
    return SizedBox(
      width: 150,
      height: 30,
      child: TextField(
          controller: editExpenseController,
          textAlign: TextAlign.start,
          onSubmitted: onSubmitted,
          focusNode: _focusNode,
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '0.00',
          )),
    );
  }

  Widget expensesDisplay(String expense, String cost) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          expense,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 52, 64, 84),
            fontWeight: FontWeight.w500,
          ),
        ),
        isEditingExpense
            ? expensesEdit()
            : Text(
          '₦$cost',
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 52, 64, 84),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
