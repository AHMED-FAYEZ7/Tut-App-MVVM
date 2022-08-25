import 'package:advance_course_flutter/app/app_prefs.dart';
import 'package:advance_course_flutter/app/di.dart';
import 'package:advance_course_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advance_course_flutter/presentation/login/login_viewmodel.dart';
import 'package:advance_course_flutter/presentation/resources/assets_manager.dart';
import 'package:advance_course_flutter/presentation/resources/color_manger.dart';
import 'package:advance_course_flutter/presentation/resources/routes_manger.dart';
import 'package:advance_course_flutter/presentation/resources/strings_manger.dart';
import 'package:advance_course_flutter/presentation/resources/values_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  LoginViewModel _viewModel = instance<LoginViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();

  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind(){
    _viewModel.start();
    _userNameController.addListener(()=>_viewModel.setUserName(_userNameController.text));
    _passwordController.addListener(()=>_viewModel.setPassword(_passwordController.text));

    _viewModel.isUserLogedInSuccessfllyStreamController.stream.listen((isSuccessLoggedIn) {
      // navigate to main
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context , snapshot){
          return snapshot.data?.getScreenWidget(
              context ,
              _getContentWidget(),
                (){
                _viewModel.login();
                }) ?? _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget(){
    return Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Image(
                  image: AssetImage(ImageAssets.splashLogo),
                ),
                const SizedBox(height: AppSize.s28,),
                Padding(padding: const EdgeInsets.only(
                    left: AppPadding.p28,right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsUserNameValid,
                      builder: (context , snapshot) {
                        return TextFormField(
                          controller: _userNameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email,
                            ),
                            hintText: AppStrings.email,
                            labelText: AppStrings.email,
                            errorText: (snapshot.data ?? true)
                              ? null :AppStrings.emailError,
                          ),
                        );
                      },
                    ),
                ),
                const SizedBox(height: AppSize.s28,),
                Padding(padding: const EdgeInsets.only(
                    left: AppPadding.p28,right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsPasswordValid,
                    builder: (context , snapshot) {
                      return TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          hintText: AppStrings.password,
                          labelText: AppStrings.password,
                          errorText: (snapshot.data ?? true)
                              ? null :AppStrings.passwordError,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s28,),
                Padding(padding: const EdgeInsets.only(
                    left: AppPadding.p28,right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputAllInputsValid,
                    builder: (context , snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? (){
                              _viewModel.login();
                            }
                            :null,
                          child: const Text(
                            AppStrings.login,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s16,),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s28
                  ),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(
                              context, Routes.forgotPasswordRoute);
                        },
                        child: Text(
                          AppStrings.forgetPassword,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(
                              context, Routes.registerRoute);
                        },
                        child: Text(
                          AppStrings.registerText,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }


  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
