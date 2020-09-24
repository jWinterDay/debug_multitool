import 'package:built_value/json_object.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_diff/json_diff.dart';
import 'package:multi_debugger/app/colors.dart';
import 'package:multi_debugger/domain/enums/payload_view_type.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/features/payload_view/blocs/payload_view_bloc.dart';
import 'package:multi_debugger/tools/common_tools.dart' as common_tools;

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

        return StreamBuilder<ServerEvent>(
          stream: _bloc.selectedEventStream,
          builder: (_, snapshot) {
            final ServerEvent currentServerEvent = snapshot.data;

            return Column(
              children: [
                // tab bar
                if (snapshot.hasData)
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
                  child: CustomScrollView(
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
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _simpleSliverItem(JsonObject obj) {
    String content = obj == null ? 'No data' : common_tools.convertJsonObject(obj);

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

  Widget _diffTitle(String title) {
    return Text(
      '$title:',
      style: const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  List<Widget> _diffItems(BeautifulDiffType type, List<BeautifulDiffResult> items) {
    String title = '';
    Color textColor = AppColors.background;
    TextDecoration textDecoration = TextDecoration.none;
    FontStyle fontStyle = FontStyle.normal;

    switch (type) {
      case BeautifulDiffType.added:
        textColor = AppColors.positive;
        title = 'Added';
        break;
      case BeautifulDiffType.changed:
        textColor = AppColors.primaryColor;
        title = 'Changed';
        break;
      case BeautifulDiffType.moved:
        textColor = AppColors.primaryColor;
        title = 'Moved';
        break;
      case BeautifulDiffType.removed:
        textColor = AppColors.red;
        title = 'Removed';
        textDecoration = TextDecoration.lineThrough;
        fontStyle = FontStyle.italic;
        break;

      default:
    }

    final List<Widget> result = items
        .where((BeautifulDiffResult item) {
          return item.diffType == type;
        })
        .map((BeautifulDiffResult item) {
          return Text(
            item.toStringForWidget(),
            style: TextStyle(
              color: textColor,
              decoration: textDecoration,
              fontStyle: fontStyle,
            ),
          );
        })
        .cast<Widget>()
        .toList();

    if (result.isNotEmpty) {
      result.insert(0, _diffTitle(title));
      result.add(const SizedBox(height: 18.0));
    }

    return result;
  }

  Widget _diffSliverItem(DiffNode diffNode) {
    final List<BeautifulDiffResult> beautifulDiff = DiffNodeExt.beautifulDiff(diffNode);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._diffItems(BeautifulDiffType.added, beautifulDiff),
            ..._diffItems(BeautifulDiffType.changed, beautifulDiff),
            ..._diffItems(BeautifulDiffType.moved, beautifulDiff),
            ..._diffItems(BeautifulDiffType.removed, beautifulDiff),
          ],
        ),
      ),
    );
  }

  // {"action": "action1", "payload": {"a": 1, "b": 2, "c": [2,3,4]}, "state": {"s1": "s1", "s2": {"a": 6, "b": 7, "c": true, "d": [1,2]}}}
  Widget _sliverItem(ServerEvent serverEvent, PayloadViewType payloadViewType) {
    // action or payload
    if ([PayloadViewType.actionPayload, PayloadViewType.state].contains(payloadViewType)) {
      final JsonObject data =
          payloadViewType == PayloadViewType.actionPayload ? serverEvent.payload : serverEvent.state;
      return _simpleSliverItem(data);
    }

    // diff
    final DiffNode diffNode = _bloc.getDiffNode(serverEvent);
    if (diffNode == null) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('Prev state is null. No diff'),
        ),
      );
    }

    return _diffSliverItem(diffNode);
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
