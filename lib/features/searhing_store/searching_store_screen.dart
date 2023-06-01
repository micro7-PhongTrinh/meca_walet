import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/meca_service.dart';
import 'package:meca_wallet/bloc/common_cubit/get_stores_cubit.dart';
import 'package:meca_wallet/constants/colors.dart';

import 'widgets/searching_stores_result.dart';
import 'widgets/store_suggest.dart';

class SearchingStoreScreen extends StatelessWidget {
  const SearchingStoreScreen({super.key});
  static String routeName = '/searchingStoreScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetStoresCubit>(
      create: (_) => GetStoresCubit(
          mecaService: RepositoryProvider.of<MecaService>(context)),
      child: const SearchingStoreBody(),
    );
  }
}

class SearchingStoreBody extends StatefulWidget {
  const SearchingStoreBody({super.key});

  @override
  State<SearchingStoreBody> createState() => _SearchingStoreBodyState();
}

class _SearchingStoreBodyState extends State<SearchingStoreBody> {
  String oldValue = '';
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    textController.addListener(() async {
      if (oldValue == textController.text) {
        return;
      }
      setState(() {
        textController.text;
      });

      oldValue = textController.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(72),
            child: SearchingStoreAppbar(textController: textController)),
        body: ResultBody(textController: textController));
  }
}

class ResultBody extends StatelessWidget {
  const ResultBody({super.key, required this.textController});

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return textController.text.isNotEmpty
        ? SearchingStoreResult(searchString: textController.text)
        : const StoreSuggest();
  }
}

class SearchingStoreAppbar extends StatelessWidget {
  const SearchingStoreAppbar({super.key, required this.textController});
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: kPrimaryPurple),
      toolbarHeight: 72,
      title: SizedBox(
        height: 64,
        child: TextFormField(
            controller: textController,
            autofocus: true,
            style: const TextStyle(
                color: kPrimaryPurple,
                fontSize: 20,
                height: 1.4,
                fontWeight: FontWeight.bold),
            cursorColor: kPrimaryPurple,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            )),
      ),
      actions: [
        if (textController.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.close),
            color: kPrimaryPurple,
            onPressed: () {
              textController.text = '';
            },
          )
      ],
      backgroundColor: Colors.white,
    );
  }
}
