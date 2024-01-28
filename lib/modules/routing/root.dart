import 'package:template/index.dart';
import 'package:template/modules/authentication/components/auth_wrap.dart';
import 'package:template/modules/routing/app_page.dart';
import 'package:template/modules/routing/nav_bar_button.dart';
import 'package:template/modules/routing/pages.dart';

final List<AppPage> pages = [homePage, profilePage];

final index = homePage.index.obs;

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: index.value);
  }

  @override
  Widget build(BuildContext context) {
    t = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AuthWrap(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: pad(v: 15),
                color: t.surface,
                child: Row(
                  children: pages
                      .map((e) => NavBarButton(
                            pageController: controller,
                            page: e,
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: pages.length,
                  controller: controller,
                  onPageChanged: (int i) => index.value = i,
                  itemBuilder: (_, i) => Obx(() => pages[index.value].page),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
