import 'package:testflow/utils/navigation.dart';

class AlertController<T> {
  final T state;

  const AlertController(this.state);

  void close() => Navigation.pop();
}
