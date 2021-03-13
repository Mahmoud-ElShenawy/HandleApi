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
          return data.map(
            data: (provider) => Center(
              child: ListView.separated(
                itemCount: provider.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(provider.value[index].title.toString()),
                      Text(provider.value[index].id.toString()),
                      Text(provider.value[index].userId.toString()),
                      Text(provider.value[index].body),
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
            loading: (_) => Center(child: CircularProgressIndicator()),
            error: (e) => Center(
              child: Text(
                e.error.toString(),
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }
}
