import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utils_test/provider//global_providers.dart';

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          final data = watch(dataProvider);
          return data.when(
            data: (provider) => Center(
              child: ListView.separated(
                itemCount: provider.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(provider[index].title.toString()),
                      Text(provider[index].id.toString()),
                      Text(provider[index].userId.toString()),
                      Text(provider[index].body),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 5,
                    ),
                  );
                },
              ),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stack) => Center(
              child: Text(
                error.toString(),
              ),
            ),
          );
        },
      ),
    );
  }
}
