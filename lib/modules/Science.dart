// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Components/components.dart';
import 'package:news/cubit/news_cubit.dart';

class ScienceScreens extends StatelessWidget {
  const ScienceScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        builder: (context, state) {
          List list = NewsCubit.get(context).science;
          if (list.length > 0) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildArticleItems(list[index], context),
              separatorBuilder: (context, index) => dividerWidget(),
              itemCount: list.length,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        listener: (context, state) {});
  }
}
