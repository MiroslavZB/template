import 'package:template/l10n/localizations.dart';
import 'package:template/utils/dialogs/get_dialog.dart';

Future<void> unexpectedErrorDialog() => getDialog(
      short: get.authError,
      middle: get.anUnexpectedError,
    );
