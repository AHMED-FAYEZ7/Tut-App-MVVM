import 'dart:async';
import 'package:advance_course_flutter/app/functions.dart';
import 'package:advance_course_flutter/domain/usecase/forgot_password_usecase.dart';
import 'package:advance_course_flutter/presentation/base/base_view_model.dart';
import 'package:advance_course_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advance_course_flutter/presentation/common/state_renderer/state_renderer.dart';


class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController = StreamController<void>.broadcast();
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  var email = "";

  ForgotPasswordViewModel(this._forgotPasswordUseCase);


  // input
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _forgotPasswordUseCase.execute(email)).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
    }, (authObject) {
      inputState.add(ContentState());
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  // output
  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream
          .map((isAllInputValid) => _isAllInputValid());

  _isAllInputValid() {
    return isEmailValid(email);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

abstract class ForgotPasswordViewModelInput {
  forgotPassword();
  setEmail(String email);

  Sink get inputEmail;
  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutput {

  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputValid;
}