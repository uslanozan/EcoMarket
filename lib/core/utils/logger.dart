import 'package:flutter/material.dart';

void logPrint({
  String? logTag,
  String? logMessage,
  bool useDebugPrint = false,
  List<Object>? values,
}){

  if(logTag!.isEmpty){
    logTag = '';
  }

  if(logMessage!.isEmpty){
    logMessage = '';
  }

  final valuesStr = values != null && values.isNotEmpty
      ? values.map((v) => v.toString()).join(', ')
      : '';

  if (useDebugPrint) {
    debugPrint('$logTag$logMessage$valuesStr');
  } else {
    print('$logTag$logMessage$valuesStr');
  }

}