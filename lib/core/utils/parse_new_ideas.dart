// New Ideas kısmından dönen cevabı widgetlar için parse edilir
//todo: Buralara hep unit test yazılacak

// Parse Ideas
import 'package:ecomarket/core/utils/logger.dart';

Map<String, String> parseIdeas({
  required String output,
}) {
  final Map<String, String> ideasMap = {};

  final lines = output.split('\n');

  logPrint(logTag: 'parseIdeas', logMessage: 'Input Result: $output');

  String? currentTitle;
  // StringBuffer verilmesinin sebebi dart'ta Stringler Immutable bu yüzden
  // String'in üstüne ekleme yapmak yeni String oluşturur ve yavaşlatır ama
  // StringBuffer her seferinde yeni nesne oluşturmaz
  StringBuffer? currentContent;

  for (final line in lines) {
    if (line.trim().startsWith('+')) {
      if (currentTitle != null && currentContent != null) {
        final contentStr = currentContent.toString().trim();
        ideasMap[currentTitle] = contentStr;
        logPrint(logTag: 'parseIdeas', logMessage: 'Added idea:\nTitle: $currentTitle\nContent: $contentStr');
      }

      final titleLine = line.trim().substring(1).trim();
      final parts = titleLine.split(':');
      currentTitle = parts.first.trim();

      currentContent = StringBuffer();
      if (parts.length > 1) {
        currentContent.writeln(parts.sublist(1).join(':').trim());
      }
    }
    else if (currentContent != null) {
      currentContent.writeln(line.trim());
    }
  }
  if (currentTitle != null && currentContent != null) {
    final contentStr = currentContent.toString().trim();
    ideasMap[currentTitle] = contentStr;
    logPrint(logTag: 'parseIdeas', logMessage: 'Added idea:\nTitle: $currentTitle\nContent: $contentStr');
  }
  return ideasMap;
}



// Parse Intro
String parseIntro({
  required String output,
}) {
  final lines = output.trim().split('\n');
  for (final line in lines) {
    if (!line.trim().startsWith('+')) {
      return line.trim();
    } else {
      break;
    }
  }
  return "";
}