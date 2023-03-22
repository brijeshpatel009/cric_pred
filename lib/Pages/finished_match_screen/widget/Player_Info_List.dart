import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../../widget/Marquee.dart';
import '../model/GetAllPlayerModel.dart';

class PlayerInfoList extends StatefulWidget {
  const PlayerInfoList(
      {Key? key,
      required this.teamPlayerList,
      required this.inning1PlayerList,
      required this.inning2PlayerList,
      required this.playerListLength,
      required this.isAllPlayerLoading})
      : super(key: key);
  final List<Playerslist> teamPlayerList;
  final List<Playerslist> inning1PlayerList;
  final List<Playerslist> inning2PlayerList;
  final int playerListLength;
  final bool isAllPlayerLoading;

  @override
  State<PlayerInfoList> createState() => _PlayerInfoListState();
}

class _PlayerInfoListState extends State<PlayerInfoList> {
  @override
  void initState() {
    super.initState();
    print("TeamPlayerList Length:=> ${widget.teamPlayerList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return widget.playerListLength > 22
        ? widget.isAllPlayerLoading
            ? const Center(
                child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
              )
            : ListView.builder(
                itemCount: 11,
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xffF1F5FE),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 9,
                            spreadRadius: -1.9,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            playerName(widget.inning1PlayerList[index].playerName),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MarqueeWidget(child: inning("INNING ${widget.inning1PlayerList[index].inning}")),
                                        MarqueeWidget(
                                          child: outby(widget.inning1PlayerList[index].isnotout == 0 && widget.inning1PlayerList[index].balls == 0
                                              ? "Not Played"
                                              : "outby: ${widget.inning1PlayerList[index].outby}"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 6),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                infoDis("${widget.inning1PlayerList[index].runs}"),
                                                infoSubTittle("Run"),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 6),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                infoDis("${widget.inning1PlayerList[index].balls}"),
                                                infoSubTittle("Balls"),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 6),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                infoDis("${widget.inning1PlayerList[index].four}"),
                                                infoSubTittle("Four"),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 6),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                infoDis("${widget.inning1PlayerList[index].six}"),
                                                infoSubTittle("Six"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (widget.inning2PlayerList.isNotEmpty) ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MarqueeWidget(child: inning("INNING ${widget.inning2PlayerList[index].inning}")),
                                          MarqueeWidget(
                                            child: outby(widget.inning2PlayerList[index].isnotout == 0 && widget.inning2PlayerList[index].balls == 0
                                                ? "Not Played"
                                                : "outby: ${widget.inning2PlayerList[index].outby}"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 6),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  infoDis("${widget.inning2PlayerList[index].runs}"),
                                                  infoSubTittle("Run"),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 6),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  infoDis("${widget.inning2PlayerList[index].balls}"),
                                                  infoSubTittle("Balls"),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 6),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  infoDis("${widget.inning2PlayerList[index].four}"),
                                                  infoSubTittle("Four"),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 6),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  infoDis("${widget.inning2PlayerList[index].six}"),
                                                  infoSubTittle("Six"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ));
                },
              )
        : widget.isAllPlayerLoading
            ? const Center(
                child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
              )
            : ListView.builder(
                itemCount: 11,
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  print("List2");
                  return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xffF1F5FE),
                        borderRadius: BorderRadius.all(Radius.circular(height * 0.03)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 9,
                            spreadRadius: -1.9,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MarqueeWidget(child: playerName(widget.teamPlayerList[index].playerName)),
                                  MarqueeWidget(
                                    child: outby(widget.teamPlayerList[index].isnotout == 0 && widget.teamPlayerList[index].balls == 0
                                        ? "Not Played"
                                        : "outby: ${widget.teamPlayerList[index].outby}"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          infoDis("${widget.teamPlayerList[index].runs}"),
                                          infoSubTittle("Run"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          infoDis("${widget.teamPlayerList[index].balls}"),
                                          infoSubTittle("Balls"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          infoDis("${widget.teamPlayerList[index].four}"),
                                          infoSubTittle("Four"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          infoDis("${widget.teamPlayerList[index].six}"),
                                          infoSubTittle("Six"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              );
  }

  Widget playerName(String string) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(string, style: TextStyle(color: const Color(0xff2E1664), fontSize: minSize * 0.05, fontWeight: FontWeight.w500)),
    );
  }

  Text inning(String string) {
    return Text(string, style: TextStyle(color: const Color(0xff535353), fontSize: minSize * 0.04));
  }

  Text outby(String string) {
    return Text(
      string,
      style: TextStyle(color: const Color(0xff000000), fontSize: minSize * 0.03),
    );
  }

  Text infoDis(String string) {
    return Text(
      string,
      style: const TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w600),
    );
  }

  Text infoSubTittle(String string) {
    return Text(
      string,
      style: const TextStyle(color: Color(0xff767676), fontWeight: FontWeight.w400),
    );
  }
}

// ListView.builder(
//         itemCount: widget.teamPlayerList.length,
//         padding: const EdgeInsets.only(top: 10),
//         itemBuilder: (context, index) {
//           return Container(
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: const Color(0xffF1F5FE),
//                 borderRadius: BorderRadius.all(Radius.circular(height * 0.03)),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black45,
//                     blurRadius: 9,
//                     spreadRadius: -1.9,
//                     offset: Offset(0.0, 0.0),
//                   )
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           MarqueeWidget(child: playerName(widget.teamPlayerList[index].playerName)),
//                           MarqueeWidget(
//                             child: outby(widget.teamPlayerList[index].isnotout == 0 && widget.teamPlayerList[index].balls == 0
//                                 ? "Not Played"
//                                 : "outby: ${widget.teamPlayerList[index].outby}"),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 6),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   infoDis("${widget.teamPlayerList[index].runs}"),
//                                   infoSubTittle("Run"),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 6),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   infoDis("${widget.teamPlayerList[index].balls}"),
//                                   infoSubTittle("Balls"),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 6),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   infoDis("${widget.teamPlayerList[index].four}"),
//                                   infoSubTittle("Four"),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 6),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   infoDis("${widget.teamPlayerList[index].six}"),
//                                   infoSubTittle("Six"),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ));
//         },
//       );
