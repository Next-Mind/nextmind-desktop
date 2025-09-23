class StatData {
  final DateTime date;
  final int value;

  StatData(this.date, this.value);
}

class ExportFilter {
  final String label;
  final List<String> options;

  ExportFilter({required this.label, required this.options});
}
