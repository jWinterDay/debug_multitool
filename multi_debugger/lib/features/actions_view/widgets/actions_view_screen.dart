import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_debugger/domain/models/models.dart';
import 'package:multi_debugger/features/actions_view/blocks/actions_view_bloc.dart';

class ActionsViewScreen extends StatefulWidget {
  const ActionsViewScreen({
    Key key,
  }) : super(key: key);

  @override
  _ActionsViewState createState() => _ActionsViewState();
}

class _ActionsViewState extends State<ActionsViewScreen> {
  ActionsViewBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = ActionsViewBloc()..init();
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

    return Column(
      children: [
        Container(
          child: Text('fdsf'),
        ),
        Expanded(
          child: StreamBuilder<List<ServerEvent>>(
            // initialData: _bloc.initServerEventState,
            stream: _bloc.serverEventStateStream,
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Text('no actions'),
                );
              }

              final List<ServerEvent> serverEventList = snapshot.data;

              // final List<List<ServerEvent>> t = serverEventState.events.values.toList();
              // final List<ServerEvent> tlist = t.isEmpty ? [] : t.first;
              // final List<String> actions = serverEventState.events.keys.toList();

              List<Widget> sliverList = serverEventList.map((ServerEvent serverEvent) {
                return SliverToBoxAdapter(
                  child: Text(serverEvent.action),
                );
              }).toList();

              // List<Widget> sliverList = actions.map((String action) {
              //   return SliverToBoxAdapter(
              //     child: Text(action),
              //   );
              // }).toList();

              return CustomScrollView(
                slivers: sliverList,
              );
            },
          ),
        ),
      ],
    );

    // return Center(
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(18.0),
    //     child: SizedBox(
    //       width: w,
    //       height: h,
    //       child: Scaffold(
    //         backgroundColor: AppColors.background,
    //         body: Center(
    //           child: Column(
    //             children: [
    //               // caption
    //               Container(
    //                 padding: const EdgeInsets.only(top: 25.0),
    //                 child: const Text(
    //                   'Saved URL',
    //                   style: const TextStyle(
    //                     color: AppColors.gray6,
    //                     fontWeight: FontWeight.w700,
    //                     fontSize: 22.0,
    //                   ),
    //                 ),
    //               ),

    //               Expanded(
    //                 child: StreamBuilder<SavedUrlState>(
    //                   initialData: _bloc.initSavedUrlState,
    //                   stream: _bloc.savedUrlStateStream,
    //                   builder: (_, snapshot) {
    //                     final SavedUrlState state = snapshot.data;

    //                     final List<SavedUrl> constSavedUrlList = _bloc.filterSavedUrl(state, custom: false);
    //                     final List<SavedUrl> customSavedUrlList = _bloc.filterSavedUrl(state);

    //                     return CustomScrollView(
    //                       physics: const ClampingScrollPhysics(),
    //                       slivers: [
    //                         // constant urls
    //                         _sliverTitle('CONSTANT'),

    //                         ..._sliverItems(constSavedUrlList),

    //                         // custom urls
    //                         _sliverTitle('CUSTOM'),

    //                         ..._sliverItems(customSavedUrlList, canRemove: true),
    //                       ],
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  // List<Widget> _sliverItems(List<SavedUrl> savedUrlList, {bool canRemove = false}) {
  //   return savedUrlList.map((SavedUrl savedUrl) {
  //     return SliverToBoxAdapter(
  //       child: InkWell(
  //         // onTap: () => _bloc.pop(context, savedUrl.url),
  //         child: Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
  //           decoration: const BoxDecoration(
  //             border: Border(
  //               bottom: BorderSide(
  //                 color: AppColors.gray3,
  //               ),
  //             ),
  //           ),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: Text(
  //                   savedUrl.url,
  //                   style: const TextStyle(
  //                     fontSize: 15.0,
  //                   ),
  //                 ),
  //               ),
  //               if (canRemove)
  //                 Container(
  //                   padding: const EdgeInsets.only(left: 5.0),
  //                   child: InkWell(
  //                     borderRadius: BorderRadius.circular(20.0),
  //                     hoverColor: AppColors.gray2,
  //                     onTap: () => _bloc.deletetUrl(savedUrl),
  //                     child: Container(
  //                       color: AppColors.transparent,
  //                       padding: const EdgeInsets.all(8.0),
  //                       alignment: Alignment.topCenter,
  //                       child: const Icon(
  //                         LoggerIcons.trash_1x,
  //                         size: 20.0,
  //                         color: AppColors.trash,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }).toList();
  // }

  // Widget _sliverTitle(String title) {
  //   return SliverToBoxAdapter(
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 15.0).copyWith(top: 15.0, bottom: 10.0),
  //       decoration: const BoxDecoration(
  //         border: Border(
  //           bottom: BorderSide(
  //             color: AppColors.gray3,
  //           ),
  //         ),
  //       ),
  //       child: Text(
  //         title,
  //         style: const TextStyle(
  //           color: AppColors.gray5,
  //           fontSize: 13.0,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
