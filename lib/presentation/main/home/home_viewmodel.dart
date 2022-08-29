import 'dart:async';
import 'dart:ffi';

import 'package:advance_course_flutter/domain/model/model.dart';
import 'package:advance_course_flutter/domain/usecase/home_usecase.dart';
import 'package:advance_course_flutter/presentation/base/base_view_model.dart';
import 'package:advance_course_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advance_course_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
  with HomeViewModelInputs , HomeViewModelOutputs{
  final StreamController _bannerStreamController = BehaviorSubject<List<BannerAd>>();
  final StreamController _servicesStreamController = BehaviorSubject<List<Service>>();
  final StreamController _storesStreamController = BehaviorSubject<List<Store>>();
  HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);
// inputs---------------------------
  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));

    (await _homeUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(StateRendererType.FULL_SCREEN_ERROR_STATE,failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputBanners.add(homeObject.data.banners);
      inputServices.add(homeObject.data.services);
      inputStores.add(homeObject.data.stores);
    });
  }

  @override
  void dispose() {
    _bannerStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannerStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

// outputs--------------------

  @override
  Stream<List<BannerAd>> get outputBanners => _bannerStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices => _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores => _storesStreamController.stream.map((stores) => stores);

}

abstract class HomeViewModelInputs{
  Sink get inputStores;
  Sink get inputServices;
  Sink get inputBanners;
}

abstract class HomeViewModelOutputs{
  Stream<List<Store>> get outputStores;
  Stream<List<Service>> get outputServices;
  Stream<List<BannerAd>> get outputBanners;
}