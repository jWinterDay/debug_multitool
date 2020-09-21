import 'package:flutter/material.dart';
import 'package:multi_debugger/app_routes.dart';
import 'package:multi_debugger/domain/base/base_bloc.dart';
import 'package:multi_debugger/domain/models/models.dart';

class ChannelDialogBloc extends BaseBloc {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void init() {
    super.init();
  }

  void removeChannel(ChannelModel channelModel) {
    appGlobals.store.actions.channelActions.removeChannel(channelModel);
  }

  void showChannelEditor(BuildContext context, ChannelModel channelModel) {
    appGlobals.store.actions.routeTo(
      AppRoute((builder) => builder
        ..route = AppRoutes.editChannel
        ..bundle = channelModel
        ..context = context),
    );
  }

  void pop(BuildContext context) {
    appGlobals.store.actions.routeTo(
      AppRoute((builder) => builder
        ..route = AppRoutes.pop
        ..context = context),
    );
  }
}
