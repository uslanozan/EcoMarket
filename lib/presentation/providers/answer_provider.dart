import 'package:ecomarket/core/models/answer.dart';
import 'package:ecomarket/core/utils/logger.dart';
import 'package:flutter/material.dart';

class AnswerProvider with ChangeNotifier {

  Answer _answer = const Answer(
      productCategory: '',
      material: '',
      targetCountry: '',
      ecoFriendly: '',
      budget: '');

  Answer get answer => _answer;


  // Fonksiyonlar immutable ve bu sayede daha az karmaşık oluyor ama heap tüketiyor ??
  // todo: copyWith() yöntemiyle heap kullanımı azaltılabilir bakılacak
  void updateProductCategory(String category) {
    _answer = Answer(
      productCategory: category,
      material: _answer.material,
      targetCountry: _answer.targetCountry,
      ecoFriendly: _answer.ecoFriendly,
      budget: _answer.budget,
    );
    logPrint(
      logTag: 'AnswerProvider',
      logMessage: 'Product category updated',
      values: [category],
      useDebugPrint: true,
    );
    notifyListeners();
  }

  void updateMaterial(String material) {
    _answer = Answer(
      productCategory: _answer.productCategory,
      material: material,
      targetCountry: _answer.targetCountry,
      ecoFriendly: _answer.ecoFriendly,
      budget: _answer.budget,
    );
    logPrint(
      logTag: 'AnswerProvider',
      logMessage: 'Material updated',
      values: [material],
      useDebugPrint: true,
    );
    notifyListeners();
  }

  void updateTargetCountry(String targetCountry) {
    _answer = Answer(
      productCategory: _answer.productCategory,
      material: _answer.material,
      targetCountry: targetCountry,
      ecoFriendly: _answer.ecoFriendly,
      budget: _answer.budget,
    );
    logPrint(
      logTag: 'AnswerProvider',
      logMessage: 'TargetCountry updated',
      values: [targetCountry],
      useDebugPrint: true,
    );
    notifyListeners();
  }

  void updateEcoFriendly(String ecoFriendly) {
    _answer = Answer(
      productCategory: _answer.productCategory,
      material: _answer.material,
      targetCountry: _answer.targetCountry,
      ecoFriendly: ecoFriendly,
      budget: _answer.budget,
    );
    logPrint(
      logTag: 'AnswerProvider',
      logMessage: 'EcoFriendly updated',
      values: [ecoFriendly],
      useDebugPrint: true,
    );
    notifyListeners();
  }

  void updateBudget(String budget) {
    _answer = Answer(
      productCategory: _answer.productCategory,
      material: _answer.material,
      targetCountry: _answer.targetCountry,
      ecoFriendly: _answer.ecoFriendly,
      budget: budget,
    );
    logPrint(
      logTag: 'AnswerProvider',
      logMessage: 'Budget updated',
      values: [budget],
      useDebugPrint: true,
    );
    notifyListeners();
  }

  void reset() {
    _answer = const Answer(
      productCategory: '',
      material: '',
      targetCountry: '',
      ecoFriendly: '',
      budget: '',
    );
    logPrint(
      logTag: 'AnswerProvider',
      logMessage: 'Answers reset',
      values: [_answer],
      useDebugPrint: true,
    );
    notifyListeners();
  }
}
