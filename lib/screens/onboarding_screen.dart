import 'package:expense_tracker/styles/font_styles/font_styles.dart';
import 'package:expense_tracker/widgets/onboarding_buttons.dart';
import 'package:flutter/material.dart';
import '../components/bottom_curve_clipper.dart';
import 'home_screen.dart';

class MultiStepOnboardingScreen extends StatefulWidget {
  const MultiStepOnboardingScreen({super.key});

  @override
  State<MultiStepOnboardingScreen> createState() =>
      _MultiStepOnboardingScreenState();
}

class _MultiStepOnboardingScreenState extends State<MultiStepOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> get _onboardingPages => [
    _buildOnboardingPage(
      context: context,
      imagePath: 'assets/images/onboard_one.png',
      title: 'Track Every Expense',
      description:
          'Stay in control of your finances by logging every income and expense—quickly and effortlessly.',
    ),
    _buildOnboardingPage(
      context: context,
      imagePath: 'assets/images/onboard_two.png',
      title: 'Visualize Your Spending',
      description:
          'Get clear insights with charts and summaries that help you understand where your money goes.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: _onboardingPages,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingPages.length,
                      (index) => _buildPageIndicator(index == _currentPage),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OnboardingButtons(
                      onSkip: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      },
                      onNext: () {
                        if (_currentPage < _onboardingPages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPageIndicator(bool isActive) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 150),
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    height: 8.0,
    width: isActive ? 24.0 : 8.0,
    decoration: BoxDecoration(
      color: isActive ? Colors.blue : Colors.grey[400],
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

Widget _buildOnboardingPage({
  required String imagePath,
  required String title,
  required String description,
  required BuildContext context,
}) {
  return Column(
    children: [
      ClipPath(
        clipper: BottomCurveClipper(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),

      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Text(title, style: onboardHeadStyle, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
              style: onboardParaStyle,
            ),
          ],
        ),
      ),
    ],
  );
}
