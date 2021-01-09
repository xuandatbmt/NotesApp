import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/models/category_model.dart';
import 'package:notes/services/data.dart';
import 'package:notes/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EditCategory extends StatefulWidget {
  final String id;
  EditCategory({this.id}) : super();
  @override
  State<StatefulWidget> createState() {
    return _EditCategoryState();
  }
}

class _EditCategoryState extends State<EditCategory> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    return Scaffold(
        body: FutureBuilder(
            future: data.fetchCateId(http.Client(), widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return EditCategoryScreen(category: snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class EditCategoryScreen extends StatefulWidget {
  final Category category;
  final String id;
  EditCategoryScreen({Key key, this.category, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EditCategorySState();
  }
}

class TextController extends TextEditingController {
  TextController({String text}) {
    this.text = text;
  }

  set text(String newText) {
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
        composing: TextRange.empty);
  }
}

class _EditCategorySState extends State<EditCategoryScreen> {
  bool isLoad = false;
  Category category;
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    if (isLoad == false) {
      setState(() {
        this.category = Category.fromCateList(widget.category);
        isLoad = true;
      });
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'Edit Category',
              icon: FontAwesomeIcons.solidSave,
              onPressed: () async {
                Map<String, dynamic> params = Map<String, dynamic>();
                params["category_name"] = this.category.categoryName.toString();
                if (category.categoryName != '') {
                  await data.updateCategory(http.Client(), params);
                  Navigator.pop(context);
                  data.update();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                maxLines: 1,
                autocorrect: false,
                decoration: InputDecoration(hintText: "Category Name"),
                controller: TextController(
                  text: this.category.categoryName,
                ),
                onChanged: (text) {
                  setState(() {
                    this.category.categoryName = text;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
