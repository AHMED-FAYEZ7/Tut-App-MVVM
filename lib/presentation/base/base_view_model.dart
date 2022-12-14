import 'dart:async';
import 'package:advance_course_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends
  BaseViewModelInputs with BaseViewModelOutputs
{
  final StreamController _inputStateStreamController = BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }
}

abstract class BaseViewModelInputs
{
  void start(); // called when init of view model
  void dispose(); // called when view model dies

  Sink get inputState;
}

abstract class BaseViewModelOutputs{
  Stream<FlowState> get outputState;
}