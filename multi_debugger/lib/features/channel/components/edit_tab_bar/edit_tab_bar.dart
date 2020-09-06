import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/models/models.dart';

import 'edit_tab_bar_bloc.dart';

class EditTabBarScreen extends StatefulWidget {
  const EditTabBarScreen({
    Key key,
    this.channelModel,
  }) : super(key: key);

  final ChannelModel channelModel;

  @override
  _EditTabBarScreenState createState() => _EditTabBarScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ChannelModel>('channelModel', channelModel));
  }
}

class _EditTabBarScreenState extends State<EditTabBarScreen> {
  EditTabBarBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = EditTabBarBloc()..init();
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double w = math.max(size.width / 3, 380);
    final double h = math.max(size.height / 3, 316);

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: SizedBox(
          width: w,
          height: h,
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: Column(
                children: [
                  // caption
                  Container(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: const Text(
                      'Add new channel',
                      style: const TextStyle(
                        color: AppColors.gray6,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 22.0,
                      ),
                    ),
                  ),

                  // computer name
                  Container(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: StreamBuilder<String>(
                      initialData: _bloc.initComputerName,
                      stream: _bloc.computerNameStream,
                      builder: (context, snapshot) {
                        final String name = snapshot.data ?? 'unknown';

                        return RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Your computer name: ',
                                style: TextStyle(color: AppColors.gray6, fontSize: 15.0),
                              ),
                              TextSpan(
                                text: name,
                                style: const TextStyle(
                                  color: AppColors.gray6,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
