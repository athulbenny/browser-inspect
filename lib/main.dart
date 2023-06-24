import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState(){super.initState();}
  TextEditingController weburl =TextEditingController();
  Future? txt;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: Scaffold(
     body: SafeArea(
       child: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             colors: [Colors.yellow,Colors.orange,Colors.green],
             begin: Alignment.topRight,
             end: Alignment.bottomCenter
           ),
         ),
         child: Column(
           children: [
           TextFormField(
            controller: weburl,
          ),
            SizedBox(height: 10,),
            GestureDetector(
                onTap: (){setState(() {
                  Part(weburl);
                });},
                 child: Icon(Icons.search,size: 25,)),
             Part(weburl),
             //Text(txt.toString()),
             // FutureBuilder<Album>(
             //     future: Search(weburl.text),
             //     builder: (context,snapshot){
             //       if(snapshot.hasData){
             //         return Text(snapshot.data!.list);
             //       }
             //       else if(snapshot.hasError) return Text('error');
             //       return const CircularProgressIndicator();
             //     }
             //
             // )
          ],
          ),
       ),
     ),),
    );
  }
}

Future<Album> Search(url) async{
  final res= await http.get(Uri.parse('${url}'));
  if(res.statusCode==200){
  return Album.from(res.body);}
  else {throw Exception('failed');}
  //return true;
}
//
// void Search() async {
//   var url = Uri.https('gcek.ac.in', '');
//   var response = await http.post(
//       url, body: {'name': 'doodle', 'color': 'blue'});
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
//
//    print(await http.read(Uri.https('example.com', '')));
// }

class Album{
  final String list;
  const Album({
    required this.list,
  });
  factory Album.from(res){
  return Album(list: res);}
}

Widget Part(weburl){
  return Expanded(
    child: SingleChildScrollView(
       scrollDirection: Axis.vertical,
      child: FutureBuilder<Album>(
          future: Search(weburl.text),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Text(snapshot.data!.list);
            }
            else if(snapshot.hasError) return Text('error');
            return const CircularProgressIndicator();
          }

      ),
    ),
  );
}