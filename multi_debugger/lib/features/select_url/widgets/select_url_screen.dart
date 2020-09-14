import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/domain/states/saved_url_state.dart';
import 'package:multi_debugger/features/select_url/blocs/select_url_bloc.dart';
import 'package:multi_debugger/tools/logger_icons.dart';

class SelectUrlScreen extends StatefulWidget {
  const SelectUrlScreen({
    Key key,
    this.channelModel,
  }) : super(key: key);

  final ChannelModel channelModel;

  @override
  _SelectUrlState createState() => _SelectUrlState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ChannelModel>('channelModel', channelModel));
  }
}

class _SelectUrlState extends State<SelectUrlScreen> {
  SelectUrlBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = SelectUrlBloc()..init();
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
                      'Saved URL',
                      style: const TextStyle(
                        color: AppColors.gray6,
                        fontWeight: FontWeight.w700,
                        fontSize: 22.0,
                      ),
                    ),
                  ),

                  Expanded(
                    child: StreamBuilder<SavedUrlState>(
                      initialData: _bloc.initSavedUrlState,
                      stream: _bloc.savedUrlStateStream,
                      builder: (_, snapshot) {
                        final SavedUrlState state = snapshot.data;

                        final List<SavedUrl> constSavedUrlList = _bloc.filterSavedUrl(state, custom: false);
                        final List<SavedUrl> customSavedUrlList = _bloc.filterSavedUrl(state);

                        return CustomScrollView(
                          physics: const ClampingScrollPhysics(),
                          slivers: [
                            // constant urls
                            _sliverTitle('CONSTANT'),

                            _sliverItems(constSavedUrlList),

                            // custom urls
                            _sliverTitle('CUSTOM'),

                            _sliverItems(customSavedUrlList, canRemove: true),
                          ],
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

  Widget _sliverItems(List<SavedUrl> savedUrlList, {bool canRemove = false}) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          SavedUrl savedUrl = savedUrlList[index];

          return InkWell(
            onTap: () => _bloc.pop(context, savedUrl.url),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.gray3,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      savedUrl.url,
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  if (canRemove)
                    Container(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        hoverColor: AppColors.gray2,
                        onTap: () => _bloc.deletetUrl(savedUrl),
                        child: Container(
                          color: AppColors.transparent,
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.topCenter,
                          child: const Icon(
                            LoggerIcons.trash_1x,
                            size: 20.0,
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        childCount: savedUrlList.length,
      ),
    );
  }

  Widget _sliverTitle(String title) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(15.0).copyWith(bottom: 10.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.gray3,
            ),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.gray5,
            fontSize: 13.0,
          ),
        ),
      ),
    );
  }
}
