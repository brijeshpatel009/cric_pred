// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/GetAllPlayerModel.dart';

class GetPlayerAndRunController extends GetxController {
  RxBool isLoading = true.obs;
  AllPlayerRunModel? allPlayerRunData;
  RxList<Playerslist> allPlayerDataList = RxList([]);

  getMatchPlayerData(int matchId, int length) async {
    isLoading.value = true;
    allPlayerDataList.clear();
    print("object");

    final http.Response allPlayerResponse = await http.post(Uri.parse('http://cricpro.cricnet.co.in/api/values/GetAllPlayers'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(<String, int>{'MatchId': matchId}));

    var response = await Dio().post(
      "http://cricpro.cricnet.co.in/api/values/GetAllPlayers",
      queryParameters: <String, dynamic>{'Content-Type': 'application/json; charset=utf-8'},
      data: {'MatchId': matchId},
    );

    print("Api Passed");

    if (response.statusCode == 200) {
      print(allPlayerResponse.body);
      allPlayerRunData = AllPlayerRunModel.fromJson(jsonDecode(allPlayerResponse.body));
      allPlayerDataList.addAll(allPlayerRunData?.playerslist ?? []);
      allPlayerDataList.refresh();
      // _parseHtmlString(commen);
      // print("...>>${allPlayerDataList[0].teamRuns}");
      isLoading.value = false;
    } else {
      print(allPlayerResponse.statusCode);
    }
  }

  getDataForLiveScore() {}
}

// String _parseHtmlString(String htmlString) {
//   final document = parse(htmlString);
//   final String parsedString = parse(document.body?.text).documentElement?.text ?? '';
//   print(parsedString);
//   return parsedString;
// }
//
// String commen =
//     "<address>\r\n\t<address>\r\n\t\t<span style=\"font-size:12px;\"><span style=\"font-family:georgia,serif;\"><var>Big Bash League 2022-23<br />\r\n\t\t27th T20 MATCH<br />\r\n\t\t<br />\r\n\t\tMelbourne Stars Vs Melbourne Renegades<br />\r\n\t\t<br />\r\n\t\tMelbourne Stars won the toss and opted to bowl first<br />\r\n\t\tRate Open 70-73 MS<br />\r\n\t\t<br />\r\n\t\tMelbourne Renegades Sessions<br />\r\n\t\tOver&nbsp; &nbsp; Open&nbsp; &nbsp; &nbsp; &nbsp;runs/wk&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Rate<br />\r\n\t\t6 Over (40-42) 44 Runs/1wk (97-97 Both)<br />\r\n\t\t10 Over (72-74) 65 Runs/3wk (56-58 MS)<br />\r\n\t\t15 Over (102-104) 105 Runs/4wk (64-66 MS)<br />\r\n\t\t20 Over (148-150) 141 Runs/7wk (43-45 MS)<br />\r\n\t\t<br />\r\n\t\tRate Open 44-46 MS<br />\r\n\t\tMelbourne Stars Session<br />\r\n\t\t<br />\r\n\t\t6 Over (40-42) 29 Runs/4wk (24-26 MR)<br />\r\n\t\t10 Over (54-56) 49 Runs/4wk (26-28 MR)<br />\r\n\t\t<br />\r\n\t\tMelbourne Renegades Won by 33 Runs</var></span></span></address>\r\n\t<br />\r\n\t<span style=\"font-size:12px;\"><span style=\"font-family:georgia,serif;\"><var>Melbourne Stars (STA) will be locking horns with Melbourne Renegades (REN) in Match 27 of the Big Bash League (BBL) 2022 at the iconic Melbourne Cricket Ground on Tuesday, January 3. Ahead of this high-octane Melbourne derby both teams have struggled for consistency in the tournament and need to pull up their socks in order to stay in contention for the knockouts going forward.</var></span></span></address>\r\n<br />\r\n<address>\r\n\t<span style=\"font-size:12px;\"><span style=\"font-family:georgia,serif;\"><var>Stars need to up their game from here on as they are languishing at the sixth position on the ladder having won just two out of their six matches with four points in their kitty at a dismal net run rate of -0.379. They head into the contest against Renegades with a narrow eight-run victory over Adelaide Strikers in their previous fixture.</var></span></span></address>\r\n<br />\r\n<br />\r\n<br />\r\n<address>\r\n\t<span style=\"font-size:12px;\"><span style=\"font-family:georgia,serif;\"><var>Melbourne Stars (STA) Possible Playing 11</var></span></span></address>\r\n<address>\r\n\t<span style=\"font-size:12px;\"><span style=\"font-family:georgia,serif;\"><var>1.Tom Fraser Rogers, 2. Joe Clarke(WK), 3. Beau Webster, 4. Marcus Stoinis, 5. Hilton Cartwright, 6. Nick Larkin, 7. Campbell Kellaway, 8. Luke Wood, 9. Trent Boult, 10. Liam Hatcher, 11. Adam Zampa(C)</var></span></span></address>\r\n<br />\r\n<address>\r\n\t<span style=\"font-size:12px;\"><span style=\"font-family:georgia,serif;\"><var>Melbourne Renegades (REN) Possible Playing 11</var></span></span></address>\r\n<address>\r\n\t<span style=\"font-size:12px;\"><span style=\"font-family:georgia,serif;\"><var>1.Martin Guptill, 2. Nic Maddinson(C), 3. Peter Handscomb(WK), 4. Aaron Finch, 5. Jonathan Wells, 6. Mackenzie Harvey, 7. Akeal Hosein, 8. Will Sutherland, 9. Tom Stewart Rogers, 10. Kane Richardson, 11. Mujeeb-ur-Rahman</var></span></span></address>\r\n<br />\r\n<br />\r\n<br />\r\n<address>\r\n\t<span style=\"font-size:12px;\"><span style=\"font-family:georgia,serif;\"><var>Squads:</var></span></span></address>\r\n<address>\r\n\t<span style=\"font-size:12px;\"><span style=\"font-family:georgia,serif;\"><var>Melbourne Stars Squad: Joe Clarke(w), Thomas Rogers, Beau Webster, Marcus Stoinis, Hilton Cartwright, Nick Larkin, Campbell Kellaway, Luke Wood, Liam Hatcher, Adam Zampa(c), Trent Boult, Nathan Coulter-Nile, Brody Couch, Clint Hinchliffe, Tom O Connell, James Seymour</var></span></span></address>\r\n<address>\r\n\t<span style=\"font-size:12px;\"><span style=\"font-family:georgia,serif;\"><var>Melbourne Renegades Squad: Martin Guptill, Jake Fraser McGurk, Sam Harper(w), Aaron Finch(c), Jonathan Wells, Mackenzie Harvey, Will Sutherland, Akeal Hosein, Tom Rogers, Kane Richardson, Mujeeb Ur Rahman, David Moody, Shaun Marsh, Jack Prestwidge, Corey Rocchiccioli</var></span></span></address>\r\n<br />\r\n<br />\r\n<address>\r\n\t<span style=\"font-size:12px;\"><span style=\"font-family:georgia,serif;\"><var>LIVE ON SONY SPORTS 2</var></span></span></address>\r\n";
