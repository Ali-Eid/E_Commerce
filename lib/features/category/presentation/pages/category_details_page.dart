import '../bloc/category/category_bloc.dart';
import '../bloc/category_details/category_details_bloc.dart';
import '../widgets/category_details/category_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart' as di;

class CategorDetailsPage extends StatelessWidget {
  final int categoryid;
  const CategorDetailsPage({Key? key, required this.categoryid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => di.sl<CategoryDetailsBloc>()
          ..add(GetDetailsCategoryEvent(categoryid)),
        child: BlocBuilder<CategoryDetailsBloc, CategoryDetailsState>(
          builder: (context, state) {
            if (state is LoadingCategoyDetailsState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedCategoyDetailsState) {
              return CategoryDetailsWidget(
                categoryDetails: state.category,
              );
              // );
            } else {
              return const Text('');
            }
          },
        ),
      ),
    );
  }
}
