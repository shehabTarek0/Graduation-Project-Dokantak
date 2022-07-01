import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/cubit.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/states.dart';
import 'package:g_project/models/merchant/get_category_model.dart';
import 'package:g_project/shared/component/constants.dart';

import '../../../shared/component/component.dart';
import 'add_category.dart';
import 'edit_category.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarCubit, MarStates>(
        builder: ((context, state) {
          if (MarCubit.get(context).allProducts != null) {
            return Scaffold(
              appBar: AppBar(
                elevation: 2,
                centerTitle: true,
                title: const Text(
                  'My Category',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              body: buildCategory(MarCubit.get(context).category),
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    navigateTo(context, const AddCategory());
                  },
                  child: const Icon(Icons.add)),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  elevation: 2,
                  centerTitle: true,
                  title: const Text(
                    'My Category',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2.5,
                    ),
                  ),
                ),
                body: const Center(child: CircularProgressIndicator()));
          }
        }),
        listener: (context, state) {});
  }

  Widget buildCategory(CategoryModel? category) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: category!.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return buildItemCat(context, category.data![index]);
      },
    );
  }

  Widget buildItemCat(context, Data data) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.35),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data.name!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                defaultButton(
                    function: () {
                      idCat = data.id!;
                      catController.text = data.name!;
                      navigateTo(context, const EditCategory());
                    },
                    text: 'Edit',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    background: const Color.fromARGB(255, 14, 181, 153),
                    width: 180,
                    height: 50,
                    radius: 7),
                const Spacer(),
                defaultButton(
                    function: () {
                      showDialog(
                          context: context,
                          builder: (context) => alert(context, data.id));
                    },
                    text: 'Delete',
                    background: const Color.fromARGB(255, 209, 0, 0),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    width: 180,
                    height: 50,
                    radius: 7),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget alert(
    context,
    int? id,
  ) {
    {
      return AlertDialog(
        title: const Text('Delete Category'),
        content: const Text('Do You Want To Delete Category'),
        actions: [
          defaultTextButton(
              text: 'yes',
              onPress: () {
                MarCubit.get(context).deleteCategory(id!);
                flutterToast(
                    text: 'Categry Deleted successfully', state: ToastStates.S);
                MarCubit.get(context).getMerCategory();
                Navigator.pop(context);
              }),
          defaultTextButton(
              text: 'No',
              onPress: () {
                Navigator.pop(context);
              })
        ],
      );
    }
  }
}
