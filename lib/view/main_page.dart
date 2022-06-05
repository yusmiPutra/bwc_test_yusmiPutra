import 'package:bwc_test/bloc/get_firebase_cubit.dart';
import 'package:bwc_test/model/res_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetFirebaseCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product List'),
          backgroundColor: Colors.green,
        ),
        body: BlocBuilder<GetFirebaseCubit, GetFirebaseState>(
          builder: (context, state) {
            GetFirebaseCubit cubit = context.read<GetFirebaseCubit>();
            if (state is GetFirebaseInitial) {
              cubit.getData();
            }
            if (state is GetFirebaseLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetFirebaseSuccess) {
              return SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  runSpacing: 16,
                  spacing: 16,
                  direction: Axis.horizontal,
                  children: List<Widget>.generate(
                    cubit.productList.length,
                    (index) {
                      Product product = cubit.productList[index];
                      return Container(
                        margin: const EdgeInsets.only(left: 12),
                        width: (index + 1) % 3 == 0
                            ? MediaQuery.of(context).size.width - 32
                            : ((MediaQuery.of(context).size.width - 24) / 2) -
                                (24 / 2),
                        height: 300,
                        child: Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                  width: double.maxFinite,
                                  imageUrl: product.image ?? '-',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(product.title ?? '-'),
                                    Text('${product.price ?? 0}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
