import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage : dart totals.dart <inputFile.csv> ');
    exit(1);
  }
  final inputFile = arguments.first;
  final lines = File(inputFile).readAsLinesSync();
  lines.removeAt(0);
  var totalDuration = 0.0;
  final TotaldurationBytag = <String, double>{};
  for (var line in lines) {
    var values = line.split(',');
    final durationStr = values[3].replaceAll('"', '');
    final duration = double.parse(durationStr);
    final tag = values[5].replaceAll('"', '');
    final previousTotal = TotaldurationBytag[tag];
    if (previousTotal == null) {
      TotaldurationBytag[tag] = duration;
    } else {
      TotaldurationBytag[tag] = previousTotal + duration;
    }
    totalDuration += duration;
  }
  for (var entry in TotaldurationBytag.entries) {
    final durationformated = entry.value.toStringAsFixed(1);
    final tag = entry.key == '' ? 'Unallocated' : entry.key;
    print('$tag : ${durationformated} h');
  }
  print('Total for all tags : ${totalDuration.toStringAsFixed(1)} h');
}
