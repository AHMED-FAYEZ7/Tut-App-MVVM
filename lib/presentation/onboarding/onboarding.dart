import 'package:advance_course_flutter/presentation/resources/assets_manager.dart';
import 'package:advance_course_flutter/presentation/resources/color_manger.dart';
import 'package:advance_course_flutter/presentation/resources/strings_manger.dart';
import 'package:advance_course_flutter/presentation/resources/values_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  late final List<SliderObject> _list = _getSliderData();
  final PageController _pageController = PageController(initialPage: 0,);
  int _currentIndex = 0;

  List<SliderObject> _getSliderData() => [
    SliderObject(
      AppStrings.onBoardingTitle1,
      AppStrings.onBoardingSubTitle1,
      ImageAssets.onBoardingLogo1,
    ),
    SliderObject(
      AppStrings.onBoardingTitle2,
      AppStrings.onBoardingSubTitle2,
      ImageAssets.onBoardingLogo2,
    ),
    SliderObject(
      AppStrings.onBoardingTitle3,
      AppStrings.onBoardingSubTitle3,
      ImageAssets.onBoardingLogo3,
    ),
    SliderObject(
      AppStrings.onBoardingTitle4,
      AppStrings.onBoardingSubTitle4,
      ImageAssets.onBoardingLogo4,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManger.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManger.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index)
        {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context , index) =>
        OnBoardingPage(_list[_currentIndex]),
      ),
      bottomSheet: Container(
        color: ColorManger.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){},
                child: Text(
                  AppStrings.skip,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            const Spacer(),
            _getBottomSheetWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() => Container(
    color: ColorManger.primary,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.leftArrow),
            ),
            onTap: ()
            {
              _pageController.animateToPage(
                  _getPreviousIndex(),
                  duration: const Duration(milliseconds:  DurationConstant.d300,),
                  curve: Curves.bounceInOut,
              );
            },
          ),
        ),
        Row(
          children: [
            for(int i=0 ; i<4 ; i++)
              Padding(padding: const EdgeInsets.all(AppPadding.p8),
                child: _getProperCircle(i),
              ),
          ],
        ),
        Padding(padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.rightArrow),
            ),
            onTap: ()
            {
              _pageController.animateToPage(
                _getNextIndex(),
                duration: const Duration(milliseconds:  DurationConstant.d300,),
                curve: Curves.bounceInOut,
              );
            },
          ),
        ),
      ],
    ),
  );

  int _getPreviousIndex()
  {
    int previousIndex = _currentIndex --;
    if(previousIndex == 0)
    {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  int _getNextIndex()
  {
    int nextIndex = _currentIndex ++;
    if(nextIndex == _list.length - 1)
    {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  Widget _getProperCircle(int index)
  {
    if(index == _currentIndex)
    {
      return SvgPicture.asset(ImageAssets.hollowCircle);
    }else
    {
      return SvgPicture.asset(ImageAssets.solidCircle);
    }
  }

}


class OnBoardingPage extends StatelessWidget {
  SliderObject _sliderObject;

  OnBoardingPage(this._sliderObject , {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40,),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(height: AppSize.s60,),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}


class SliderObject
{
  String title;
  String subTitle;
  String image;

  SliderObject(
      this.title,
      this.subTitle,
      this.image,
      );
}
