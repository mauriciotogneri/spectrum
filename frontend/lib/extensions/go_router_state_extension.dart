import 'package:go_router/go_router.dart';

extension GoRouterStateExtension on GoRouterState {
  String param(String name) => pathParameters[name]!;
}
