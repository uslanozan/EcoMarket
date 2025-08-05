// New Ideas kısmından dönen cevabı widgetlar için parse edilir
//todo: Buralara hep unit test yazılacak

// Parse Ideas
import 'package:ecomarket/core/utils/logger.dart';

//todo: JSON formatında gelecek bilgileri parse'layacak fonksiyon yazılacak ve widget içerisinde onlar kullanılacak
//todo: her propmt için ayrı
//todo: login page yapılacak


// Parse New Ideas Ideas
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

// Parse New Ideas Intro
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


//todo: BURALAR DÜZELTİLECEK
// Ana bölümleri parse eden fonksiyon
Map<String, Map<String, dynamic>> parseSections(String wholeOutput) {
  final Map<String, Map<String, dynamic>> result = {};
  final sectionPattern = RegExp(r'\+([^+]+)\+');
  final matches = sectionPattern.allMatches(wholeOutput).toList();

  for (var i = 0; i < matches.length; i++) {
    final title = matches[i].group(1)?.trim() ?? 'Unknown';
    final startIndex = matches[i].end;
    final endIndex = (i + 1 < matches.length) ? matches[i + 1].start : wholeOutput.length;
    final content = wholeOutput.substring(startIndex, endIndex).trim();

    final bool hasList = content.contains('++');

    if (hasList) {
      final itemPattern = RegExp(r'\+\+(.+?)\+\+:?\s*(.*?)\s*(?=(\+\+|$))', dotAll: true);
      final itemMatches = itemPattern.allMatches(content);
      final List<Map<String, String>> items = [];

      for (final match in itemMatches) {
        final itemTitle = match.group(1)?.trim() ?? '';
        final itemDesc = match.group(2)?.trim() ?? '';
        items.add({
          'title': itemTitle,
          'description': itemDesc,
        });
      }

      result[title] = {
        'hasList': true,
        'content': items,
      };
    } else {
      result[title] = {
        'hasList': false,
        'content': content,
      };
    }
  }

  return result;
}

/*
// todo: hatalı sonra düzeltilebilir
Map<String, Map<String, dynamic>> xparseSections(String wholeOutput) {
  Map<String, Map<String, dynamic>> result = {};

  String pattern ='+';
  StringBuffer section = StringBuffer();
  StringBuffer title = StringBuffer();
  bool hasList = false;

  for(int i = 0; i < wholeOutput.length; i++){
    if(wholeOutput[i]=='+' && (wholeOutput.length <= i+1 && wholeOutput[i+1] != '+')){
      while(wholeOutput[i+1] != '+'){
        title.write(wholeOutput[i]);
        i++;
      }
    }
    if(wholeOutput[i]=='+'){
      hasList = true;
    }
    section.write(wholeOutput[i]);
  }

return result;
}
*/


// Alt liste elemanlarını parse eden fonksiyon
Map<String, String> parseSubItems(String sectionContent) {
  final Map<String, String> subItems = {};

  // Alt başlıklar ++Başlık++: Açıklama şeklinde olduğundan pattern kullanalım
  final itemPattern = RegExp(r'\+\+([^+]+)\+\+\s*:\s*([^\n]+)');

  for (final match in itemPattern.allMatches(sectionContent)) {
    final key = match.group(1)?.trim() ?? 'Unknown';
    final value = match.group(2)?.trim() ?? '';
    subItems[key] = value;
  }

  return subItems;
}


//todo: ImproveProduct için de parser yazılması gerekebilir
//todo:  için de parser yazılması gerekebilir
