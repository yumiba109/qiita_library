import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_library/viewModels/article_view_model.dart';

class ArticleSearchSettingPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(articleViewModel);
    final state = useProvider(articleViewModel.state);

    return Scaffold(
      appBar: AppBar(
        title: Text('検索'),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: TextEditingController(text: state.keyword),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'キーワード',
              ),
              onFieldSubmitted: (value) async {
                await viewModel.setQuery(value);
                viewModel.getArticles();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
