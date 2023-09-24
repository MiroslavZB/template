import 'package:vegex/utils/custom_widgets/custom_widgets_index.dart';

Widget snapshotInfo({List<Widget>? children, Widget? child}) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children ?? [if (child != null) child],
      ),
    );

Widget loadingInfo() {
  return snapshotInfo(
    children: [
      const CircularProgressIndicator(),
      Padding(
        padding: pad(rp: 10),
        child: txts('Loading...'),
      ),
    ],
  );
}

Widget noInternetInfo() {
  return snapshotInfo(child: txts('Error: No internet connection!'));
}

Widget errorInfo() {
  return snapshotInfo(child: const Text('Something went wrong'));
}
