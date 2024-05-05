// import 'dart:js';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../modules/news_app/web_view/webView_screen.dart';
import '../cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.orange,
  bool isUPPerCase = true,
  double radius = 0.0,
  required Function function,
  required String text,
    Function? suffixPressed,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed:() {
          function;
        },
        child: Text(
          isUPPerCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
   ValueChanged<String>? onSubmit,
   ValueChanged<String>? onChange,
   GestureTapCallback? onTap,

  required String? Function(String?)? validate,

  bool isPassword = false,
  bool isClackable = true,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: (String? s) {
        onSubmit?.call(s!);
      },
      onTap: () {
        onTap?.call();
      },
      onChanged: (String? s) {
        onChange?.call(s!);
      },
      validator: validate,
      enabled: isClackable,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null, // Wrap the prefix in an Icon widget
      ),
    );

PreferredSizeWidget defualtAppBar({
  required BuildContext context,
  String? title,
  List<Widget>?actions,
})=>AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon:  Image.asset(
      'assets/images/arrow_left.png',
      width: 24,
      height: 24,
    ),
  ),
  title: Text(
    title!,
    style: TextStyle(
      color: HexColor('#67A3D9')
    ),
  ),
  actions: actions,
);

Widget buildTaskItem(Map model,context) =>Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
  padding: const EdgeInsets.all(12.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 35.0,
        backgroundColor: Colors.redAccent,
        child: Text(
          '${model['time']}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      const SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${model['title']}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${model['date']}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),

      ),
      const SizedBox(
        width: 20.0,
      ),
      IconButton(
        onPressed: (){
          AppCubit.get(context).updateData(
            status:'Done',
            id:model['id'],

          );
        },
        icon: Icon(Icons.check_box,
          color: Colors.green,
        ),
      ),
      IconButton(
        onPressed: (){
          AppCubit.get(context).updateData(
            status:'archive',
            id:model['id'],
          );
        },
        icon: Icon(Icons.archive,
          color: Colors.grey,
        ),
      ),
    ],
  ),
),
  onDismissed: (direction){
    AppCubit.get(context).deletData(id: model['id']);
  },
);
Widget taskBuilder({
  required List<Map>tasks
})=>ConditionalBuilder(
  condition:tasks.length>0 ,
  builder: (context)=>ListView.separated(
    itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),
    separatorBuilder: (context,index)=>myDivider(),
    itemCount:tasks.length ,
  ),
  fallback: (context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100,
          color: Colors.grey,
        ),
        Text('No tasks yet,please add tasks',
          style:TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ) ,
        ),
      ],
    ),
  ),
);
Widget myDivider() => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
Widget buildArticleItem(Map<String, dynamic> article,context) =>InkWell(
  onTap: (){
    // navigateTo(context, WebViewScreen(article['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

void navigateTo(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        ( route)
    {
      return false;
    }
  );
}

void showToast({
  required String text,
  required ToastState state,
})=>
Fluttertoast.showToast(
                    msg:text,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.TOP ,
                    timeInSecForIosWeb: 5,
                    backgroundColor: chooseToastColor(state),
                    textColor: Colors.white,
                    fontSize: 16.0
                );

enum ToastState{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastState state)
{
Color color;
switch(state)
{
case ToastState.SUCCESS:
color= Colors.green;
break;
case ToastState.ERROR:
color= Colors.red;
break;
case ToastState.WARNING:
color= Colors.amber;
break;
}
return color;
}

