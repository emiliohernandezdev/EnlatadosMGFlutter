import 'dart:convert';

class Stock {
  Stock(
      {required this.correlative,
      required this.entryDate});

  int correlative;
  DateTime entryDate;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
      correlative: json["correlative"],
      entryDate: DateTime.parse(json["entryDate"]));
  Map<String, dynamic> toJson() => {"correlative": correlative, "entryDate": entryDate};
}
