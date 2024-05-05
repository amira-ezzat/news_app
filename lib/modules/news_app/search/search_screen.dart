import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../../shared/compononse/components.dart';


class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
        listener: (context,state){},
        builder: (context,state){
          var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange:(value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'search must not empty';
                    }
                    return null;
                  },
                  label: 'search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return buildArticleItem(list[index],context);
                  },
                ),
              ),
            ],
          ),
        );
    },

    );
  }
}
