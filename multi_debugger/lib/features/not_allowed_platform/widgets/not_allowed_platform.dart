import 'package:flutter/material.dart';
import 'package:multi_debugger/app/colors.dart';

import 'package:multi_debugger/features/not_allowed_platform/blocs/not_allowed_platform_bloc.dart';

class NotAllowedPlatformScreen extends StatefulWidget {
  const NotAllowedPlatformScreen({
    Key key,
  }) : super(key: key);

  @override
  _NotAllowedPlatformScreenState createState() => _NotAllowedPlatformScreenState();
}

class _NotAllowedPlatformScreenState extends State<NotAllowedPlatformScreen> {
  NotAllowedPlatformBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = NotAllowedPlatformBloc()..init();
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Not allowed platform.\nApp used only for desktop or web(ToDo) platforms',
          style: const TextStyle(
            color: AppColors.gray6,
            fontWeight: FontWeight.w700,
            fontSize: 22.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
