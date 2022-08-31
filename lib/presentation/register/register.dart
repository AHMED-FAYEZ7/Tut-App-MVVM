
import 'dart:io';

import 'package:advance_course_flutter/app/app_prefs.dart';
import 'package:advance_course_flutter/app/di.dart';
import 'package:advance_course_flutter/app/extensions.dart';
import 'package:advance_course_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advance_course_flutter/presentation/register/register_viewmodel.dart';
import 'package:advance_course_flutter/presentation/resources/assets_manager.dart';
import 'package:advance_course_flutter/presentation/resources/color_manger.dart';
import 'package:advance_course_flutter/presentation/resources/routes_manger.dart';
import 'package:advance_course_flutter/presentation/resources/strings_manger.dart';
import 'package:advance_course_flutter/presentation/resources/values_manger.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker picker = instance<ImagePicker>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  _bind(){
    _viewModel.start();
    _userNameController.addListener(() {_viewModel.setUserName(_userNameController.text);});
    _emailController.addListener(() {_viewModel.setEmail(_emailController.text);});
    _passwordController.addListener(() {_viewModel.setPassword(_passwordController.text);});
    _mobileNumberController.addListener(() {_viewModel.setMobileNumber(_mobileNumberController.text);});

    _viewModel.isUserRegisterInSuccessfullyStreamController.stream.listen((isSuccessRegisterIn) {
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
      appBar: AppBar(
        backgroundColor: ColorManger.white,
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManger.primary),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context , snapshot){
          return Center(
            child: snapshot.data?.getScreenWidget(context , _getContentWidget(),
                    (){
                  _viewModel.register();
                }) ?? _getContentWidget(),
          );
        },
      ),
    );
  }

  Widget _getContentWidget(){
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p8),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Image(
                image: AssetImage(ImageAssets.splashLogo),
              ),
              const SizedBox(height: AppSize.s18,),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorUserName,
                  builder: (context , snapshot) {
                    return TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                        ),
                        hintText: AppStrings.username.tr(),
                        labelText: AppStrings.username.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s18,),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorEmail,
                  builder: (context , snapshot) {
                    return TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                        hintText: AppStrings.email.tr(),
                        labelText: AppStrings.email.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s18,),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorPassword,
                  builder: (context , snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        hintText: AppStrings.password.tr(),
                        labelText: AppStrings.password.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s18,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: CountryCodePicker(
                        onChanged: (country){
                          // update view with selected code
                          _viewModel.setCountryCode(country.dialCode ?? EMPTY);
                        },
                        initialSelection: "+33",
                        showCountryOnly: true,
                        hideMainText: true,
                        showOnlyCountryWhenClosed: true,
                        favorite: const ["+966","+02","+39"],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: StreamBuilder<String?>(
                        stream: _viewModel.outputErrorMobileNumber,
                        builder: (context , snapshot) {
                          return TextFormField(
                            controller: _mobileNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.phone,
                              ),
                              hintText: AppStrings.phone.tr(),
                              labelText: AppStrings.phone.tr(),
                              errorText: snapshot.data,
                            ),
                          );
                        },
                      ),
                    ),
                  ],),
                ),
              ),
              const SizedBox(height: AppSize.s18,),
              Padding(
                padding: EdgeInsets.only(
                    top: AppPadding.p12,
                    left: AppPadding.p28, right: AppPadding.p28),
                child: Container(
                  height: AppSize.s40,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorManger.lightGrey)),
                  child: GestureDetector(
                    child: _getMediaWidget(),
                    onTap: () {
                      _showPicker(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s18,),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsAllInputsValid,
                  builder: (context , snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? (){
                          _viewModel.register();
                        }
                            :null,
                        child: Text(
                          AppStrings.register.tr(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s12,),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.s28
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppStrings.loginText.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(AppStrings.profilePicture.tr())),
          Flexible(
              child: StreamBuilder<File?>(
                stream: _viewModel.outputProfilePicture,
                builder: (context, snapshot) {
                  return _imagePickedByUser(snapshot.data);
                },
              )),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCamera)),
        ],
      ),
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  trailing: Icon(Icons.arrow_forward),
                  leading: Icon(Icons.camera),
                  title: Text(AppStrings.photoGalley.tr()),
                  onTap: () {
                    _imageFormGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  trailing: Icon(Icons.arrow_forward),
                  leading: Icon(Icons.camera_alt_rounded),
                  title: Text(AppStrings.photoCamera.tr()),
                  onTap: () {
                    _imageFormCamera();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  _imageFormGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFormCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
