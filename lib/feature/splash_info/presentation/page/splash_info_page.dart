import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';
import 'package:twogether/feature/splash_info/presentation/presentation.dart';

class SplashInfoPage extends StatefulWidget {
  const SplashInfoPage({super.key});

  @override
  State<SplashInfoPage> createState() => _SplashInfoPageState();
}

class _SplashInfoPageState extends State<SplashInfoPage> {
  PageController _controller = PageController();

  // cek jika page terakhir atau bukan
  bool onLastPage = false;
  bool onFirstPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
        children: [
          // Splash Info Page

          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
                onFirstPage = (index == 0);
              });
            },
            children: [
              IntroPage(
                title: Config().appName,
                logo: Config().appLogo,
                contentTitle: 'Temukan Tempat Sampah Terdekat!',
                content: '2Gether membantumu untuk menemukan tempat sampah terdekat. Buanglah sampah sesuai kategori!',
                contentLogo: Config().intro1,
              ),
              IntroPage(
                title: Config().appName,
                logo: Config().appLogo,
                contentTitle: 'Mari Berkreasi dengan sampah Daur Ulang :)',
                content: '2Gether membantumu memberikan ide-ide untuk membuat prakaryamu. Buatlah karya terbaikmu!',
                contentLogo: Config().intro2,
              ),
              IntroPage(
                title: Config().appName,
                logo: Config().appLogo,
                contentTitle: 'Temukan Tempat Sampah Terdekat!',
                content: '2Gether siap menjadi mitramu untuk membantu bumi menjadi lebih baik dengan menyediakan tempat sampah!',
                contentLogo: Config().intro3,
              ),
            ],
          ),

          // Dot Indicator

          Container(
            alignment: const Alignment(0, 0.70),
            child: SmoothPageIndicator(
              controller: _controller, 
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Config().semiGreenColor,
                dotColor: Config().youngGreenColor,
                expansionFactor: 3,
                dotHeight: 8,
              ),
              onDotClicked: (index) {
                _controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
            ),
          ),

          Positioned(
            left: 20,
            right: 20,
            bottom: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                onFirstPage ? 
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, PagePath.login);
                      // _controller.jumpToPage(2)
                    },
                    child: Text(
                      "Lewati",
                      style: TextStyle(
                        fontSize: Config().smallTextSize,
                        fontWeight: FontWeight.w500,
                        color: Config().grayColor,
                      ),
                    ),
                  ) : 
                  GestureDetector(
                    onTap: () {
                      _controller.previousPage(duration: const Duration(microseconds: 500), curve: Curves.easeIn);
                    },
                    child: Text(
                      "Kembali",
                      style: TextStyle(
                        fontSize: Config().smallTextSize,
                        fontWeight: FontWeight.w500,
                        color: Config().grayColor,
                      ),
                    ),
                  ),

                onLastPage ? 
                  Container(
                    decoration: BoxDecoration(
                        color: Config().semiGreenColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    padding: const EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.pushReplacementNamed(context, PagePath.login)
                      },
                      child: Row(
                        children: [
                          Text(
                            "Get Start",
                            style: TextStyle(
                              fontSize: Config().smallTextSize,
                              fontWeight: FontWeight.w500,
                              color: Config().whiteColor,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              size: Config().mediumTextSize,
                              color: Config().whiteColor,
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, PagePath.login);
                            },
                          )
                        ],
                      ),
                    )
                  ) : 
                  Container(
                    decoration: BoxDecoration(
                        color: Config().semiGreenColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        size: Config().mediumTextSize,
                        color: Config().whiteColor,
                      ),
                      onPressed: () {
                        _controller.nextPage(duration: const Duration(microseconds: 500), curve: Curves.easeIn);
                      },
                    ),
                  )

              ],
            ),
          )

        ],
       )
    );
  }
}