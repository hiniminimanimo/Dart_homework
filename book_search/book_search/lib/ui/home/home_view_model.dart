
import 'package:book_search/data/model/book.dart';
import 'package:book_search/data/repository/book_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final BookRepository _repository = BookRepository();
  
  List<Book> _books = [];
  List<Book> get books => _books;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> searchBooks(String query) async {
    if (query.trim().isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      _books = await _repository.getBooks(query);
    } catch (e) {
      // 에러가 나면 빈 리스트로 초기화 (나중에 에러 처리도 할 수 있어요)
      _books = [];
      print('에러가 났어요: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
