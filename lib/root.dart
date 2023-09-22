import 'package:template/components/account/account_deletion_icon.dart';
import 'package:template/components/account/exit_icon.dart';
import 'package:template/models/page.dart';
import 'package:template/routing/pages.dart';
import 'package:template/services/authentication.dart';
import 'package:template/utils/custom_widgets/custom_widgets_index.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

List<AppPage> pages = [homePage];

int index = homePage.index;

class _RootState extends State<Root> {
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    final titles = ['Home'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(appName, style: textSH1),
        leading: Authentication.auth.currentUser == null ? null : exitIcon(),
        actions: Authentication.auth.currentUser == null ? null : [accountDeletionIcon()],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: pages.length,
              controller: pageController,
              onPageChanged: (int i) => setState(() => index = i),
              itemBuilder: (_, i) => pages[i].page,
            ),
          ),
          Container(
            padding: pad(v: 15),
            color: backgroundVariation,
            child: Row(children: pages.map((e) => pageButton(e, titles)).toList()),
          ),
          Padding(
            padding: pad(v: 20),
            child: const Center(
              child: Text('Advertising Banner Here'),
            ),
          ),
        ],
      ),
    );
  }

  Widget pageButton(AppPage page, List<String> titles) {
    return Expanded(
      child: InkWell(
        onTap: () => pageController.animateToPage(
          page.index,
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              page.icon,
              color: pages.indexOf(page) == index ? accentColor : Colors.black,
            ),
            Text(titles[page.index]),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
