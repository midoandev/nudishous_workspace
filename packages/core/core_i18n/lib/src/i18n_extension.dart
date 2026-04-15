import 'package:flutter/material.dart';

import 'i18n_impl.dart';
import 'messages.i69n.dart';

extension I18nExtension on BuildContext {
  /// how use: context.s.app.title
  Messages get s => I18n.s;
}