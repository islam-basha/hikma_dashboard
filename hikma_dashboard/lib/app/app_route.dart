import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hikma_dashboard/features/add/presentation/add_page.dart';
import 'package:hikma_dashboard/features/home/presentation/home_page.dart';
import 'package:hikma_dashboard/features/login/presentation/login_page.dart';
import 'package:hikma_dashboard/features/show/presentation/edit_page.dart';
import 'package:hikma_dashboard/features/show/presentation/show_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final goRouterProvider = Provider((ref) => hikmaAppRoute(ref));

GoRouter hikmaAppRoute(Ref ref){
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/intro',
    routes: [
      GoRoute(
        path: '/intro',
        name: 'intro',
        builder: (context, state) => const LogInPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/add',
        name: 'add',
        builder: (context, state) => const AddPage(),
      ),
      GoRoute(
        path: '/show',
        name: 'show',
        builder: (context, state) => const ShowPage(),
      ),
      GoRoute(
          path: '/edit',
          name: 'edit',
          builder: (context, state) {
            return EditHadithPage(hadithId: state.extra.toString(),);
          }
      ),
    ]
  );

}