import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kudo0/Final_grid.dart';
import 'main.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'My_Providers.dart';

class PLay_Form extends StatefulWidget {
  final String PlName,P2Name;
  PLay_Form(this.PlName,this.P2Name){
  }
  @override
  _PLay_FormState createState()=> _PLay_FormState();
}

class _PLay_FormState extends State<PLay_Form> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width= size.width;

    void _showDialog() {
      slideDialog.showSlideDialog(backgroundColor:Colors.lightBlueAccent[50] ,pillColor: Colors.blue[900],barrierDismissible: false,transitionDuration: Duration(milliseconds: 500),
        context: context,
        child: SingleChildScrollView(scrollDirection: Axis.vertical,controller: ScrollController(keepScrollOffset: true),
          child: Flex(direction: Axis.vertical,mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text(' Congratulation ‎',style: TextStyle(fontSize: width/15,fontWeight: FontWeight.bold),)
              ,Text('${Provider.of<Last_Active>(context, listen: false).Get_Winner_Name()}',
                style: TextStyle(fontSize: width/15,fontWeight: FontWeight.bold),),
              Image.asset('asset/Gcup.png',width:width/2,)

              ,
              RaisedButton(color:Colors.lightBlue,onPressed:(){
                Provider.of<Last_Active>(context,listen:false).Reset_Grid();
                RestartWidget.restartApp(context);
              }, child: Text('Play again ?')),
              RaisedButton(color: Colors.black26,onPressed: (){
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              }, child:  Text('Exit'))

              ,Align(child: Text('Slide down to show game board',style: TextStyle(fontWeight: FontWeight.bold),),alignment: Alignment.bottomCenter,),
            ],),
        ),
      );
    }

    void isfinised()
    {
      if( Provider.of<Last_Active>(context, listen: false).Finish_the_Game()==true)
        _showDialog();
    }

    return  MaterialApp(debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.comfortable,
        ),
        home:Scaffold(appBar: AppBar(title:Text(' Think.. ',style: TextStyle(fontFamily: 'GoudyOlsStyle',fontWeight: FontWeight.bold),),),
          body: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomRight,colors: [Colors.white,Color(0Xffc2e9fb),Color(0Xffa1c4fd)],)),
            child:
            GestureDetector(child: Grid(widget.PlName,widget.P2Name,isfinised)
            ,onTap: isfinised,),
          ),
        ));
  }
}
