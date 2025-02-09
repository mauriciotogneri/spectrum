import 'dart:async';
import 'package:event_bus/event_bus.dart';
import 'package:testflow/utils/locator.dart';
import 'package:testflow/utils/log.dart';

class Events {
  final EventBus _eventBus = EventBus();

  static Events get _get => locator<Events>();

  static void emit(dynamic event) {
    Log.trace('Event', '${event.runtimeType}.post');
    _get._eventBus.fire(event);
  }

  static StreamSubscription listen<T>(Function(T) onData) =>
      _get._eventBus.on<T>().listen(onData);
}

class Event {
  const Event();

  void post() => Events.emit(this);
}
