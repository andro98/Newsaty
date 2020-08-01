import 'package:flutter/material.dart';
import 'package:newsaty/Model/DataModels/NewsByCategory.dart';
import 'package:newsaty/Model/DataModels/NewsCategory.dart';
import 'package:newsaty/Model/Services/NewsService.dart';

enum Status { Busy, Success, Error }

class NewsProvider extends ChangeNotifier {
  NewsService _newsService = NewsService();
  NewsByCategory newsByCategory;
  Status newsByCategoryStatus = Status.Busy;
  String newsByCategoryMessage;

  List<NewCategory> categories = [
    NewCategory(color: Colors.deepPurple, name: 'General', isSelected: true),
    NewCategory(color: Colors.deepOrange, name: 'Buisiness', isSelected: false),
    NewCategory(color: Colors.black, name: 'Entertainment', isSelected: false),
    NewCategory(color: Colors.redAccent, name: 'Health', isSelected: false),
    NewCategory(color: Colors.blue, name: 'Science', isSelected: false),
    NewCategory(color: Colors.green, name: 'Sports', isSelected: false),
    NewCategory(color: Colors.teal, name: 'Technology', isSelected: false),
  ];

  void getHeadlinesByCategory(String newCategory) async {
    newsByCategoryStatus = Status.Busy;
    notifyListeners();
    try {
      newsByCategory =
          await _newsService.getHeadlinesByCategory(newCategory);
      newsByCategoryStatus = Status.Success;
    } catch (e) {
      newsByCategoryMessage = e.toString();
      newsByCategoryStatus = Status.Error;
    }
    notifyListeners();
  }
}
