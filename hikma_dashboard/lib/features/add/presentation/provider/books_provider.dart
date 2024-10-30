import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hikma_dashboard/features/add/data/add_repository.dart';
import 'package:hikma_dashboard/features/add/domain/books_model.dart';

class BooksNotifier extends AutoDisposeAsyncNotifier{

  Object? key;
  List<BooksModel>? cardsList;

  @override
  FutureOr build() {
    key = Object();
    ref.onDispose(() {
      key = null;
    });
    return showBooks();
  }

  Future showBooks() async {

    state = const AsyncValue.loading();
    final key = this.key;
    print('in pro ===========');
    cardsList = await AddReposirory().showFutureBooks();
    print(cardsList);
    if (key != this.key) {
      return null;
    }
    return state.value;
  }

}


final booksNotifier = AutoDisposeAsyncNotifierProvider(BooksNotifier.new);
