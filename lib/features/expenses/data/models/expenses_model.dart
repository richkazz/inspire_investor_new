class ExpensesModel {
  final String expense;
  final String cost;

  const ExpensesModel({
    required this.expense,
    required this.cost,
  });

  factory ExpensesModel.fromJson(Map<String, dynamic> json) {
    return ExpensesModel(
      expense: json['expense'],
      cost: json['cost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expense': expense,
      'cost': cost,
    };
  }
}
