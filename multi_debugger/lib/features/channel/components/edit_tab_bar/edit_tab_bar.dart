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

  final InputDecoration _inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(0.0),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.gray3),
      borderRadius: BorderRadius.circular(6.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.gray3),
      borderRadius: BorderRadius.circular(6.0),
    ),
    hintStyle: const TextStyle(
      color: AppColors.gray5,
      fontSize: 15.0,
    ),
  );

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
                                style: TextStyle(
                                  color: AppColors.gray6,
                                  fontSize: 15.0,
                                ),
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

                  // channel name
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 10.0),
                    child: TextField(
                      autofocus: true,
                      onChanged: _bloc.onNameChanged,
                      cursorColor: AppColors.positive,
                      style: const TextStyle(
                        color: AppColors.gray5,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                      decoration: _inputDecoration.copyWith(hintText: 'Channel name'),
                    ),
                  ),

                  // short name caption
                  Container(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: const Text(
                      'Short channel name (max: 15 symbols):',
                      style: const TextStyle(
                        color: AppColors.gray6,
                        fontSize: 15.0,
                      ),
                    ),
                  ),

                  // short name
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 10.0),
                    child: TextField(
                      onChanged: _bloc.onShortNameChanged,
                      cursorColor: AppColors.positive,
                      style: const TextStyle(
                        color: AppColors.gray5,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                      decoration: _inputDecoration.copyWith(hintText: 'Short name'),
                    ),
                  ),

                  // buttons
                  const SizedBox(
                    height: 25.0,
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            _bloc.pop(context);
                          },
                          textColor: AppColors.positive,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            'CANCEL',
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ),
                        StreamBuilder<bool>(
                          stream: _bloc.correctFormStream,
                          builder: (_, snapshot) {
                            final bool correct = snapshot.data ?? false;

                            return RaisedButton(
                              onPressed: correct ? () => _bloc.addChannel(context) : null,
                              color: AppColors.positive,
                              textColor: AppColors.background,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: const Text(
                                'ADD CHANNEL',
                                style: TextStyle(fontSize: 17.0),
                              ),
                            );
                          },
                        ),
                      ],
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
