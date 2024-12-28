import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}
