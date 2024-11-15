import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DateEx on DateTime {
  String get toFormattedDate => '$day / $month / $year';
  // String get getDayName {
  //   DateFormat formatter = DateFormat('E');
  //   return formatter.format(this);
  // }
  String getDayName(DateTime date, BuildContext context) {
    List<String> days = [
      AppLocalizations.of(context)!.sunday,
      AppLocalizations.of(context)!.monday,
      AppLocalizations.of(context)!.tuesday,
      AppLocalizations.of(context)!.wednesday,
      AppLocalizations.of(context)!.thursday,
      AppLocalizations.of(context)!.friday,
      AppLocalizations.of(context)!.saturday
    ];
    return days[weekday - 1];
  }
}
