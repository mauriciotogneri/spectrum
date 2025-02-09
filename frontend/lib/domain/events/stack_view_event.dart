import 'package:flutter/material.dart';
import 'package:testflow/domain/events/events.dart';

class StackViewEvent extends Event {
  final Widget view;

  const StackViewEvent(this.view);
}
