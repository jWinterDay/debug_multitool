import 'dart:math' as math;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/base/pair.dart';
import 'package:multi_debugger/domain/enums/payload_view_type.dart';
import 'package:multi_debugger/domain/enums/server_event_type.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/features/actions_view/blocs/actions_view_bloc.dart';
import 'package:multi_debugger/features/payload_view/blocs/payload_view_bloc.dart';
import 'package:multi_debugger/tools/common_tools.dart' as common_tools;
import 'package:multi_debugger/tools/logger_icons.dart';

class PayloadViewScreen extends StatefulWidget {
  const PayloadViewScreen({
    Key key,
  }) : super(key: key);

  @override
  _PayloadViewState createState() => _PayloadViewState();
}

class _PayloadViewState extends State<PayloadViewScreen> {
  PayloadViewBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = PayloadViewBloc()..init();
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PayloadViewType>(
      initialData: PayloadViewType.actionPayload,
      stream: _bloc.payloadViewTypeStream,
      builder: (_, snapshot) {
        final PayloadViewType currentPayloadViewType = snapshot.data;

        return Column(
          children: [
            // tab bar
            Row(
              children: [
                _tabBarItem(
                  'ACTION PAYLOAD',
                  payloadViewType: PayloadViewType.actionPayload,
                  currentPayloadViewType: currentPayloadViewType,
                ),
                _tabBarItem(
                  'STATE',
                  payloadViewType: PayloadViewType.state,
                  currentPayloadViewType: currentPayloadViewType,
                ),
                _tabBarItem(
                  'DIFF',
                  payloadViewType: PayloadViewType.diff,
                  currentPayloadViewType: currentPayloadViewType,
                ),
              ],
            ),

            // data
            Expanded(
              child: StreamBuilder<ServerEvent>(
                stream: _bloc.selectedEventStream,
                builder: (_, snapshot) {
                  final ServerEvent currentServerEvent = snapshot.data;

                  return CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      // no data
                      if (!snapshot.hasData)
                        const SliverFillRemaining(
                          child: Center(
                            child: Text(
                              'Select action',
                              style: const TextStyle(
                                color: AppColors.gray6,
                                fontSize: 17.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          //  Text('no data'),
                        )
                      else
                        _sliverItem(currentServerEvent, currentPayloadViewType),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // {"action": "action1", "payload": {"a": 1, "b": 2, "c": [2,3,4]}, "state": {"s1": "s1", "s2": {"a": 6, "b": 7, "c": true, "d": [1,2]}}}
  Widget _sliverItem(ServerEvent serverEvent, PayloadViewType payloadViewType) {
    String content = 'No data';

    switch (payloadViewType) {
      case PayloadViewType.actionPayload:
        content = serverEvent.payload == null ? 'No data' : common_tools.convertJsonObject(serverEvent.payload);
        break;
      case PayloadViewType.state:
        content = serverEvent.state == null ? 'No data' : common_tools.convertJsonObject(serverEvent.state);
        break;
      case PayloadViewType.diff:
        content = serverEvent.payload == null ? 'No data' : 'ToDo';
        break;
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          content,
          style: const TextStyle(
            color: AppColors.bodyText2Color,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }

  Widget _tabBarItem(
    String title, {
    @required PayloadViewType payloadViewType,
    @required PayloadViewType currentPayloadViewType,
  }) {
    final bool selected = payloadViewType == currentPayloadViewType;

    return Expanded(
      child: InkWell(
        onTap: () => _bloc.selectTabBar(payloadViewType),
        child: Container(
          height: 52,
          padding: const EdgeInsets.only(top: 15.0),
          decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                color: AppColors.gray3,
                offset: Offset(0, 1),
              ),
            ],
            border: selected
                ? const Border(
                    bottom: BorderSide(
                      width: 4.0,
                      color: AppColors.positive,
                    ),
                  )
                : null,
            color: AppColors.background,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: selected ? AppColors.positive : AppColors.gray5,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
