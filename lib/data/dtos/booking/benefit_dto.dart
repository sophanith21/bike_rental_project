import 'package:bike_rental_project/model/booking/benefit.dart';
import 'package:bike_rental_project/ui/utils/icon_dictionary.dart';

class BenefitDto {
  static const String iconDataKey = 'iconData';
  static const String labelKey = 'label';

  static Benefit fromJson(Map<String, dynamic> json) {
    assert(json[iconDataKey] is String);
    assert(json[labelKey] is String);

    return Benefit(
      iconData: IconDictionary.fromKey(json[iconDataKey]),
      label: json[labelKey],
    );
  }

  static Map<String, dynamic> toJson(Benefit benefit) {
    return {
      "iconData": IconDictionary.toKey(benefit.iconData),
      "label": benefit.label,
    };
  }
}
