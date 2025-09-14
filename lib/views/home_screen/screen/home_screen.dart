import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
      backgroundColor: AppTheme.backgroundColor(context),
      appBar: AppBar(
        centerTitle: true,
        title: Text("home".tr()),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.account_circle))
        ],
      ),
      body:GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [

        ],
      ),
    );
  }
}
