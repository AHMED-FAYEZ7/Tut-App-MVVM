abstract class BaseViewModel extends
  BaseViewModelInputs with BaseViewModelOutputs{}

abstract class BaseViewModelInputs
{
  void start(); // called when init of view model
  void dispose(); // called when view model dies
}

abstract class BaseViewModelOutputs{}