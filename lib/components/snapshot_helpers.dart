import 'package:template/index.dart';

class _SnapshotInfo extends StatelessWidget {
  final List<Widget>? children;
  final Widget? child;
  const _SnapshotInfo({this.children, this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children ?? [if (child != null) child!],
      ),
    );
  }
}

class LoadingInfo extends StatelessWidget {
  const LoadingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return _SnapshotInfo(
      children: [
        const CircularProgressIndicator(),
        Padding(
          padding: pad(tp: 10),
          child: Txts('${get.loading}...'),
        ),
      ],
    );
  }
}

class NoInternetInfo extends StatelessWidget {
  const NoInternetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return _SnapshotInfo(child: Txts(get.errorNoInternet));
  }
}

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return _SnapshotInfo(child: Txts(get.anUnexpectedError));
  }
}
