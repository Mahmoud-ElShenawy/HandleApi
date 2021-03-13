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
            data: (data) => Center(
              child: ListView.separated(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data[index].title.toString()),
                      Text(data[index].id.toString()),
                      Text(data[index].userId.toString()),
                      Text(data[index].body),
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
                'Error',
              ),
            ),
          );
        },
      ),
    );
  }
}
