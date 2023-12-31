// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Results extends StatefulWidget {
//   const Results({super.key, required this.linker});
//   // final ContractLinker linker;
//   @override
//   State<Results> createState() => _ResultsState();
// }

// class _ResultsState extends State<Results> {
//   @override
//   void initState() {
//     super.initState();
//     // widget.linker.loadCandidates2();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ContractLinker>(
//       create: (context) => widget.linker,
//       child: SizedBox(
//         width: double.infinity,
//         child: Column(
//           children: [
//             Row(children: [
//               const Expanded(
//                   child: Text("Results",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ))),
//               IconButton(
//                   onPressed: () {
//                     setState(() {
//                       // widget.linker.loadCandidates2();
//                     });
//                   },
//                   icon: const Icon(Icons.refresh))
//             ]),
//             const SizedBox(
//               height: 10,
//             ),
//             Consumer<ContractLinker>(
//               builder: (context, linker, _) => FutureBuilder(
//                 future: linker.candidates,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Column(
//                       children: [
//                         const Text("Loading"),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Center(
//                           child: CircularProgressIndicator(
//                             color: Colors.grey.shade600.withAlpha(200),
//                           ),
//                         )
//                       ],
//                     );
//                   } else if (snapshot.hasError) {
//                     return const Text("Error Loading");
//                   } else {
//                     return SizedBox(
//                         // height: 300,
//                         child: Table(
//                             border: TableBorder.all(),
//                             defaultColumnWidth: const FlexColumnWidth(),
//                             children: () {
//                               var m = [
//                                 TableRow(
//                                   children: [
//                                     Container(
//                                         decoration: BoxDecoration(
//                                             color: Colors.grey.withAlpha(100)),
//                                         height: 30,
//                                         alignment: Alignment.center,
//                                         child: const Text(
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.bold),
//                                             "Name")),
//                                     Container(
//                                         decoration: BoxDecoration(
//                                             color: Colors.grey.withAlpha(100)),
//                                         height: 30,
//                                         alignment: Alignment.center,
//                                         child: const Text(
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.bold),
//                                             "Votes"))
//                                   ],
//                                 ),
//                               ];
//                               m.addAll(snapshot.data!.map((e) => TableRow(
//                                     children: [
//                                       Container(
//                                           height: 30,
//                                           alignment: Alignment.center,
//                                           child: Text(e.name)),
//                                       Container(
//                                           height: 30,
//                                           alignment: Alignment.center,
//                                           child: Text(
//                                               e.voteCount.toInt().toString()))
//                                     ],
//                                   )));
//                               return m;
//                             }()));
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
