import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class IconDictionary {
  static const Map<String, IconData> _keyToIcon = {
    'clock': Symbols.nest_clock_farsight_analog,
    'calendar': Symbols.calendar_check,
    'bike': Symbols.pedal_bike_rounded,
  };

  // Safe lookup: gets the IconData from a string key
  static IconData fromKey(String key) => _keyToIcon[key] ?? Symbols.help;

  // Reverse lookup: gets the string key from IconData (for the DTO's toJson)
  static String toKey(IconData icon) {
    return _keyToIcon.entries
        .firstWhere(
          (e) => e.value == icon,
          orElse: () => _keyToIcon.entries.first,
        )
        .key;
  }
}
