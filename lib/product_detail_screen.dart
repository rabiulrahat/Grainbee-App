// import 'package:flutter/material.dart';
// import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var _idDiaSem = 'seg';

//   @override
//   Widget build(BuildContext context) {
//     final dayOfWeekMeals = meals
//         .where((meal) => meal.idDiaSem.any((idDiaSem) => idDiaSem == _idDiaSem))
//         .toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Gastronomia'),
//       ),
//       body: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               //  Container(
//               //   height: 100,
//               //   width: 80,
//               //   child: GlassFlexContainer(
//               //     border: BorderSide.strokeAlignInside,
//               //     child: SemanaButton(
//               //       'Segunda',
//               //       onPressed: () => setState(() => _idDiaSem = 'seg'),
//               //       selected: _idDiaSem == 'seg',
//               //     ),
//               //   ),
//               // ),
//               SemanaButton(
//                 'Segunda',
//                 onPressed: () => setState(() => _idDiaSem = 'seg'),
//                 selected: _idDiaSem == 'seg',
//               ),
//               SemanaButton(
//                 'Terça',
//                 onPressed: () => setState(() => _idDiaSem = 'ter'),
//                 selected: _idDiaSem == 'ter',
//               ),
//               SemanaButton(
//                 'Quarta',
//                 onPressed: () => setState(() => _idDiaSem = 'qua'),
//                 selected: _idDiaSem == 'qua',
//               ),
//               SemanaButton(
//                 'Quinta',
//                 onPressed: () => setState(() => _idDiaSem = 'qui'),
//                 selected: _idDiaSem == 'qui',
//               ),
//               SemanaButton(
//                 'Sexta',
//                 onPressed: () => setState(() => _idDiaSem = 'sex'),
//                 selected: _idDiaSem == 'sex',
//               ),
//             ],
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: dayOfWeekMeals.length,
//               itemBuilder: (ctx, index) {
//                 return Card(
//                   elevation: 0,
//                   margin: (index == dayOfWeekMeals.length - 1)
//                       ? const EdgeInsets.only(bottom: 0, left: 20, right: 20)
//                       : const EdgeInsets.only(left: 20, right: 20),
//                   child: ClipRRect(
//                     borderRadius: (index == 0)
//                         ? const BorderRadius.only(
//                             topLeft: Radius.circular(50),
//                             topRight: Radius.circular(50),
//                           )
//                         : (index == dayOfWeekMeals.length - 1)
//                             ? const BorderRadius.only(
//                                 bottomLeft: Radius.circular(50),
//                                 bottomRight: Radius.circular(50),
//                               )
//                             : BorderRadius.circular(0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(dayOfWeekMeals[index].descricao),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//         ],
//       ),
//     );
//   }
// }

// class SemanaButton extends StatelessWidget {
//   final String text;
//   final bool? selected;
//   final VoidCallback onPressed;
//   const SemanaButton(
//     this.text, {
//     Key? key,
//     required this.onPressed,
//     this.selected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child:
//       //   Container(
//       //   height: 100,
//       //   width: 80,
//       //   child: GlassFlexContainer(
//       //     border: BorderSide.strokeAlignInside,
//       //     child: Column(
//       //       children: [
//       //         Padding(
//       //           padding: const EdgeInsets.all(8.0),
//       //           child: Container(
//       //             child: Image(
//       //               image: NetworkImage(
//       //                   'https://freepngimg.com/thumb/cucumber/1-2-cucumber-png-hd-thumb.png'),
//       //               width: 60,
//       //               height: 50,
//       //             ),
//       //           ),
//       //         ),
//       //         Center(
//       //             child: GlassText(
//       //           "Vegetable",
//       //           color: Colors.white,
//       //           fontWeight: FontWeight.bold,
//       //         )),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//       Text(
//         '$text \n____________',
//         textAlign: TextAlign.start,
//         style: TextStyle(
//           fontSize: 50,
//           color:
//               selected == true ? Theme.of(context).colorScheme.primary : Colors.amber,
//           fontWeight: selected == true ? FontWeight.bold : null,
//         ),
//       ),
//     );
//   }
// }

// class Meal {
//   final String id;
//   final String descricao;
//   final List<String> ingredients;
//   final List<String> idDiaSem;
//   final String imageUrl;

//   const Meal({
//     required this.id,
//     required this.descricao,
//     required this.ingredients,
//     required this.idDiaSem,
//     required this.imageUrl,
//   });
// }

// var id = 0;

// final meals = [
//   Meal(
//     id: '${++id}',
//     descricao: 'Feijão Tropeiro',
//     ingredients: [],
//     idDiaSem: ['seg'],
//     imageUrl: '',
//   ),
//   Meal(
//     id: '${++id}',
//     descricao: 'Feijoada',
//     ingredients: [],
//     idDiaSem: ['sex'],
//     imageUrl: '',
//   ),
//   Meal(
//     id: '${++id}',
//     descricao: 'Batata Doce Caramelada',
//     ingredients: [],
//     idDiaSem: ['seg'],
//     imageUrl: '',
//   ),
//   Meal(
//     id: '${++id}',
//     descricao: 'Cubos Suínos ao Molho Escuro',
//     ingredients: [],
//     idDiaSem: ['seg'],
//     imageUrl: '',
//   ),
//   Meal(
//     id: '${++id}',
//     descricao: 'Enrolado de Salsicha',
//     ingredients: [],
//     idDiaSem: ['seg'],
//     imageUrl: '',
//   ),
//   Meal(
//     id: '${++id}',
//     descricao: 'Doce e Fruta',
//     ingredients: [],
//     idDiaSem: ['seg', 'ter', 'qua', 'qui', 'sex'],
//     imageUrl: '',
//   ),
//   Meal(
//     id: '${++id}',
//     descricao: 'Buffet de Saladas',
//     ingredients: [],
//     idDiaSem: ['seg', 'ter', 'qua', 'qui', 'sex'],
//     imageUrl: '',
//   ),
// ];
