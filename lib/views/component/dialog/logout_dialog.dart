import 'package:flutter/material.dart';
import 'package:instagram_clone/views/component/constant/string.dart';
import 'package:instagram_clone/views/component/dialog/alert_dialog_model.dart';

@immutable
class LogOutDialog extends AlertDialogModel<bool> {
  const LogOutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureYouWantToLogOutFromThisApp,
          buttons: const {
            Strings.cancel: false,
            Strings.logOut: true,
          },
        );
}
