import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personal_app/src/pages/login/login_init.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});
  static const routeName = '/onBoarding';

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: [
              buildPage(
                  color: const Color.fromARGB(255, 255, 92, 0),
                  title: 'Descubra do que seu corpo é capaz',
                  subtitle:
                      'Conecte com personais especializados que irão potencializar seus ganhos ',
                  urlImage: 'assets/images/onBoarding/step1.svg'),
              buildPage(
                  color: Colors.blue.shade100,
                  title: 'Descubra novas modalidades',
                  subtitle:
                      'Explore novas maneiras de manter sua mente conectada com o corpo e o universo',
                  urlImage: 'assets/images/onBoarding/step2.svg'),
              buildPage(
                  color: Colors.green.shade100,
                  title: 'Acompanhe sua evolução através de metas',
                  subtitle:
                      'Adicione metas para acompanhar seus resultados através de gráficos personalizados',
                  urlImage: 'assets/images/onBoarding/step3.svg'),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.teal.shade700,
                    minimumSize: const Size.fromHeight(80)),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginInit()),
                  );
                },
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 80,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text('SKIP'),
                      onPressed: () => controller.jumpToPage(2),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: WormEffect(
                            spacing: 16,
                            dotColor: Colors.black26,
                            activeDotColor: Colors.teal.shade700),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn),
                      ),
                    ),
                    TextButton(
                      child: const Text('NEXT'),
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                    ),
                  ],
                ),
              ),
      );

  buildPage(
          {required Color color,
          required String title,
          required String subtitle,
          required String urlImage}) =>
      Container(
          color: color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                    child: Stack(
                  children: [
                    Positioned(
                      top: 50,
                      child: SvgPicture.asset(
                        'assets/images/onBoarding/cloud.svg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                    SvgPicture.asset(
                      urlImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300,
                    ),
                  ],
                )),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 50, 0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          subtitle,
                          style: const TextStyle(
                            color: Color(0xFF2E2929),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ));
}
