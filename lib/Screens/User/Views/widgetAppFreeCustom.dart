
import 'package:cardmonix/Screens/User/Giftcards/giftcardRate.dart';
import 'package:cardmonix/utils/height.dart';
import 'package:flutter/material.dart';

class WidgetAppFreeCustom extends StatefulWidget{
  final String text;
  final String text2;

  const WidgetAppFreeCustom({
    Key? key,
    required this.text,
    required this.text2,
  }) : super(key: key);

 @override
  WidgetAppFreeCustomState createState()=> WidgetAppFreeCustomState();
}

class WidgetAppFreeCustomState extends State<WidgetAppFreeCustom>{
  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap:(){
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Giftcards()));
        },
      child: Container(
         color:Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:25.0,right:25.0),
              child: Container(
                width: double.infinity-20,
                height: 80,
               
                decoration: BoxDecoration(
                   color: const Color.fromARGB(255, 232, 235, 237),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                   border: Border.all(
                  
                  width: 0.6, 
                  style: BorderStyle.solid,
                  color: Color.fromARGB(136, 90, 90, 90)
                ),
               
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.card_giftcard),
                     
                          
                          Container(
                            width: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[ Text(widget.text,style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                              ),),
                              Text(widget.text2,style: const TextStyle(
                                fontSize: 10
                              ),),
                              ]
                            ),
                          ),
                         
                      Icon(Icons.chevron_right),
                
                    ],
                  ),
                ),
                
              ),
            ),
            Utils.sizedBoxHeight(20),
          ],
        ),
      ),
    );
  }
}