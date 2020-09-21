import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/models/models.dart';

import 'edit_tab_bar_bloc.dart';

final InputDecoration _kInputDecoration = InputDecoration(
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
  bool get _existsChannel => widget.channelModel != null;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _shortNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _bloc = EditTabBarBloc()..init();

    if (_existsChannel) {
      final String name = widget.channelModel.name;
      final String shortName = widget.channelModel.shortName;

      _nameController.text = name;
      _shortNameController.text = shortName;
      _bloc.toggleInitialValues(name: name, shortName: shortName);
    }
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
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(
                      _existsChannel ? 'Edit channel name' : 'Add new channel',
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
                      controller: _nameController,
                      autofocus: true,
                      onChanged: _bloc.onNameChanged,
                      cursorColor: AppColors.positive,
                      style: const TextStyle(
                        color: AppColors.gray5,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                      decoration: _kInputDecoration.copyWith(hintText: 'Channel name'),
                    ),
                  ),

                  // short name caption
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: Text(
                      'Short channel name (max: 15 symbols):',
                      style: TextStyle(
                        color: AppColors.gray6,
                        fontSize: 15.0,
                      ),
                    ),
                  ),

                  // short name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 10.0),
                    child: TextField(
                      controller: _shortNameController,
                      onChanged: _bloc.onShortNameChanged,
                      cursorColor: AppColors.positive,
                      style: const TextStyle(
                        color: AppColors.gray5,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                      decoration: _kInputDecoration.copyWith(hintText: 'Short name'),
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
                          initialData: _existsChannel,
                          stream: _bloc.correctFormStream,
                          builder: (_, snapshot) {
                            final bool correct = snapshot.data ?? false;

                            return RaisedButton(
                              onPressed: correct
                                  ? () {
                                      _existsChannel ? _bloc.updateChannel(widget.channelModel) : _bloc.addChannel();
                                      _bloc.pop(context);
                                    }
                                  : null,
                              color: AppColors.positive,
                              textColor: AppColors.background,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Text(
                                _existsChannel ? 'EDIT CHANNEL' : 'ADD CHANNEL',
                                style: const TextStyle(fontSize: 17.0),
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
