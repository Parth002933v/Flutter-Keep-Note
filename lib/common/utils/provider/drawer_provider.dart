import 'package:flutter_note_taker/common/utils/enums/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDrawerItemProvider = StateProvider<EnumDrawerItems>((ref) {
  return EnumDrawerItems.notes; // Default selected item
});
