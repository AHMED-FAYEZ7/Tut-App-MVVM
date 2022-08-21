import 'dart:async';

import 'package:advance_course_flutter/domain/usecase/login_usecase.dart';
import 'package:advance_course_flutter/presentation/base/base_view_model.dart';
import 'package:advance_course_flutter/presentation/common/freezed_data_classes.dart';
import 'package:advance_course_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advance_course_flutter/presentation/common/state_renderer/state_renderer.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {

  StreamController _userNameStreamController = StreamController<String>.broadcast();
  StreamController _passwordStreamController = StreamController<String>.broadcast();
  StreamController _isAllInputValidStreamController = StreamController<void>.broadcast();

  var loginObject = LoginObject("","");

  LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  // inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  void start() {
    // view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAllInputsValid => _isAllInputValidStreamController.sink;

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(
        LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
          // left -> failure
          inputState.add(ErrorState(
              StateRendererType.POPUP_ERROR_STATE, failure.message))
        },
            (data) => {
          // right -> success (data)
          inputState.add(ContentState())

          // navigate to main screen after the login
        });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  // outputs
  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid =>
      _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputAllInputsValid => _isAllInputValidStreamController.stream
      .map((_) => _isAllInputsValid());

  /////////// private functions////////////////////////

  _validate(){
    inputAllInputsValid.add(null);
  }

  bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName){
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid(){
    return _isPasswordValid(loginObject.password) &&
    _isUserNameValid(loginObject.userName);
  }



}

abstract class LoginViewModelInputs {
  // three functions for actions
  setUserName(String userName);

  setPassword(String password);

  login();

// two sinks for streams
  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputAllInputsValid;
}