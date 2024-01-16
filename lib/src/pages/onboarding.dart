import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personal_app/src/pages/sample_feature/sample_item_details_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

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
                  color: const Color.fromARGB(255, 255, 183, 142),
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

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => SampleItemDetailsView()),
                  );
                },
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 80,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                urlImage,
                fit: BoxFit.cover,
                width: double.infinity, // Ajuste a largura conforme necessário
                height: 200, // Ajuste a altura conforme necessário
              ),
              const SizedBox(height: 64),
              Text(title,
                  style: TextStyle(
                    color: Colors.teal.shade700,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(),
                child:
                    Text(subtitle, style: const TextStyle(color: Colors.black)),
              )
            ],
          ));
}
