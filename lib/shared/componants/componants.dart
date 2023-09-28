import 'package:flutter/material.dart';

Widget defultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isupper = true,
  double redius = 5.0,
  // ignore: use_function_type_syntax_for_parameters
  required Function() fun1,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: fun1,
        child: Text(
          isupper ? text.toUpperCase() : text,
          style: const TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
var d = TextEditingController();
var s = TextStyle(
  color: Colors.grey[3000],
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);
Widget defultfromfild(
        {IconData? sufix,
        Function()? ontap,
        required TextEditingController controller,
        required TextInputType type,
        required Function(String) fin1,
        required String? Function(String?) valdidate,
        required String text,
        double radius = 10.0,
        Color background = Colors.white,
        Function()? sufixprass,
        required IconData prfix,
        bool ispassword = false,
        bool isclicklable = true}) =>
    TextFormField(
      enabled: isclicklable,
      obscureText: ispassword,
      validator: valdidate,
      controller: controller,
      style: s,
      onFieldSubmitted: fin1,
      keyboardType: type,
      onTap: ontap,
      decoration: InputDecoration(
        suffix: sufix != null
            ? IconButton(onPressed: sufixprass, icon: Icon(sufix))
            : null,
        prefix: Icon(prfix),
        labelText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
      ),
    );

Widget bulidTaskItem(Map modle) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[500],
            radius: 40.0,
            child: Text(
              '${modle['time']}',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${modle['title']}',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${modle['data']}',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
