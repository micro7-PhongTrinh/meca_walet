import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/features/store/bloc/get_event_cubit.dart';

import '../../../widgets/event_card.dart';
import 'store_box_content.dart';

class HappeningEvents extends StatelessWidget {
  const HappeningEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: const StoreBoxContent(
          title: 'Sự kiện đang diễn ra', widget: ListEvent()),
    );
  }
}

class ListEvent extends StatelessWidget {
  const ListEvent({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetEventCubit>(context).getStoreEvent('123');
    return BlocBuilder<GetEventCubit, GetEventState>(
        bloc: BlocProvider.of<GetEventCubit>(context),
        builder: (context, state) {
          if (state is GetEventSuccess) {
            return Column(
              children: List.generate(
                  state.events.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: EventCard(event: state.events[index]),
                      )),
            );
          }
          return Container();
        });
  }
}
