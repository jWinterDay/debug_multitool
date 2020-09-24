import 'dart:math' as math;

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/enums/filter_list_type.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/features/filter_list/blocs/filter_list_bloc.dart';
import 'package:multi_debugger/tools/logger_icons.dart';

class FilterListScreen extends StatefulWidget {
  const FilterListScreen({
    Key key,
    this.filterListType,
  }) : super(key: key);

  final FilterListType filterListType;

  @override
  _FilterListState createState() => _FilterListState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FilterListType>('filterListType', filterListType));
  }
}

class _FilterListState extends State<FilterListScreen> {
  FilterListBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = FilterListBloc()..init();
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

    String title = '';

    switch (widget.filterListType) {
      case FilterListType.white:
        title = 'White list';
        break;

      case FilterListType.black:
        title = 'Black list';
        break;
    }

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
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.gray6,
                        fontWeight: FontWeight.w700,
                        fontSize: 22.0,
                      ),
                    ),
                  ),

                  Expanded(
                    child: StreamBuilder<ChannelModel>(
                      initialData: _bloc.currentChannelModel,
                      stream: _bloc.currentChannelModelStream,
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }

                        final ChannelModel currentChannelModel = snapshot.data;

                        BuiltList<String> filterList;

                        switch (widget.filterListType) {
                          case FilterListType.white:
                            filterList = currentChannelModel.whiteList;
                            break;
                          case FilterListType.black:
                            filterList = currentChannelModel.blackList;
                            break;
                          default:
                            filterList = BuiltList<String>.from(<String>[]);
                        }

                        return CustomScrollView(
                          physics: const ClampingScrollPhysics(),
                          slivers: [
                            if (filterList.isEmpty)
                              const SliverFillRemaining(
                                child: Center(
                                  child: Text(
                                    'No filters',
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                      color: AppColors.gray6,
                                    ),
                                  ),
                                ),
                              )
                            else
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return _item(filterList[index]);
                                  },
                                  childCount: filterList.length,
                                ),
                              ),
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

  Widget _item(String filter) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0).copyWith(left: 15.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.gray3,
          ),
        ),
      ),
      child: Row(
        children: [
          // name
          Expanded(
            child: Text(
              filter,
              style: const TextStyle(fontSize: 15.0),
            ),
          ),

          // remove
          Container(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () => _bloc.deleteItem(widget.filterListType, filter),
              child: const Icon(
                LoggerIcons.trash_1x,
                size: 20.0,
                color: AppColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
