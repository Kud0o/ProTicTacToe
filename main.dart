import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'My_Providers.dart';
import 'Final_grid.dart';
import 'My_Providers.dart';
import 'package:kudo0/Cell_Class.dart';
import 'Front_Page.dart';
void main() {
  runApp(RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(  providers: [
   ChangeNotifierProvider(create: (_)=>Last_Active()),
      ChangeNotifierProvider(create: (_)=>Current_player()),
    ] ,
      child: MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Pro X,O',
        theme: ThemeData(fontFamily:'GoudyOlsStyle',
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.standard,
        ),
        home: MyHomePage(title: 'Pro X&O'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  @override
  Widget build(BuildContext context) {
    /*List<List<List<List<int>>>> Grid = [[[[1,0,0] , [0,0,0] ,[0,0,0]],[[0,0,0] , [0,0,0] ,[0,0,0]],[[0,0,0] , [0,0,0] ,[0,0,0]]] ,
      [[[0,0,0] , [0,0,0] ,[0,0,0]],[[0,0,0] , [0,0,0] ,[0,0,0]],[[0,0,0] , [0,0,0] ,[0,0,0]]] ,
      [[[0,0,0] , [0,0,0] ,[0,0,0]],[[0,0,0] , [0,0,0] ,[0,0,0]],[[0,0,0] , [0,0,0] ,[0,0,0]]]];*/
    return /* SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Container(child:Grid()),floatingActionButton:FloatingActionButton(child: Icon(Icons.add),
        onPressed: (){
          cell_info c = context.read<Last_Active>().Last_Hitted;
          var f = context.read<Last_Active>().Big_Grid;
          var fv = context.read<Last_Active>().Big_Grid_Validation;
          print('Last hitted : Row: ${c.Row_indx} and Col: ${c.Col_indx}');
          print(f);
          print(fv);
        },) ,
         // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  */
  StartForm();
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
