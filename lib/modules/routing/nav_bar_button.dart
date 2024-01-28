import 'package:template/index.dart';
import 'package:template/modules/routing/app_page.dart';
import 'package:template/modules/routing/root.dart';

class NavBarButton extends StatelessWidget {
  final PageController pageController;
  final AppPage page;

  const NavBarButton({
    super.key,
    required this.pageController,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => pageController.jumpToPage(
          page.index,
          // curve: Curves.decelerate,
          // duration: const Duration(milliseconds: 300),
        ),
        child: Obx(
          () => Icon(
            page.icon,
            size: 50,
            color: pages.indexOf(page) == index.value ? t.primary : Colors.black,
          ),
        ),
      ),
    );
  }
}
