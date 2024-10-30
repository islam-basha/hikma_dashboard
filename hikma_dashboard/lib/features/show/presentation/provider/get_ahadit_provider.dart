import 'dart:async';

import 'package:riverpod/riverpod.dart';

import '../../data/get_ahadith_repository.dart';
import '../../domain/ahadith_model.dart';


class MainSearchProvider extends AutoDisposeAsyncNotifier{

  Object? key;
  List<AhadithModel>? ahadithList;

  @override
  FutureOr build() {
    key = Object();
    ref.onDispose(() {
      key = null;
    });
    return showAhadith();
  }

  Future showAhadith(
      ) async {
    state = const AsyncValue.loading();
    final key = this.key;
    ahadithList = await GetAhadithRepository().showFutureAhadith(ref);
    if (key != this.key) {
      return null;
    }
    return state.value;
  }

}


final mainSearchProvider = AutoDisposeAsyncNotifierProvider(MainSearchProvider.new);
