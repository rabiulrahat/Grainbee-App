// body: Center(
//         child: SizedBox(
//           child: Stack(
//             alignment: AlignmentDirectional.topCenter,
//             fit: StackFit.loose,
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: NeonPoint(
//                   pointSize: 00,
//                   pointColor: Colors.red.shade100,
//                   spreadColor: Colors.greenAccent,
//                   lightSpreadRadius: 80,
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomLeft,
//                 child: NeonPoint(
//                   pointSize: 00,
//                   pointColor: Colors.red.shade100,
//                   spreadColor: Colors.greenAccent,
//                   lightSpreadRadius: 100,
//                 ),
//               ),
//               //form  design
//               SizedBox(
//                 height: 650,
//                 width: 320,
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: GlossyContainer(
//                     width: 600,
//                     height: 500,
//                     borderRadius: BorderRadius.circular(30),
//                     color: Colors.white12,
//                     child: const Center(
//                       child: Column(
//                         //here  i declared one column and row,
//                         children: [
//                           //this is row of text
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 40,
//                                 height: 160,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(5.0),
//                                 child: Text(
//                                   'Registration',
//                                   style: TextStyle(
//                                     fontSize: 40,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),

//                                SizedBox(
//                                 width: 40,
//                                 height: 160,
//                               ),
//                                Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 16),
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     hintText: 'Enter a search term',
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 width: 200,
//               ),
//               //here  has main icon of our registration page
//               NeonContainer(
//                   spreadColor: Colors.greenAccent,
//                   borderWidth: 2,
//                   borderColor: Colors.greenAccent,
//                   borderRadius: BorderRadius.circular(1120.90),
//                   child: const Image(
//                       // alignment: Alignment.ce,
//                       width: 200.0,
//                       height: 200.0,
//                       image: AssetImage("assets/image.png"))),
//             ],
//           ),
//         ),
//       ),

