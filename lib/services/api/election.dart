import 'package:intl/intl.dart';
import 'package:vote/services/api/api.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/api_types.dart';

class ElectionStatisticsTime {
  final DateTime time;
  final int votes;
  const ElectionStatisticsTime({required this.time, required this.votes});

  @override
  String toString() {
    return "Time: $time, Votes: $votes";
  }
}

class ElectionCall extends APIClass {
  Future<List<ElectionStatisticsTime>> getElectionStatisticsTime(
      {required String electionId,
      String gap = 'hour',
      DateTime? startTime,
      DateTime? endTIme}) async {
    var val = await getCallNormal(
        '/api/election/add-vote/',
        {
          'election': electionId,
          'type': 'time',
          'gap': gap,
          'start_time': startTime != null
              ? DateFormat('yyyy-MM-dd HH:mm:ss').format(startTime.toUtc())
              : null,
          'end_time': endTIme != null
              ? DateFormat('yyyy-MM-dd HH:mm:ss').format(endTIme.toUtc())
              : null
        },
        SystemConfig.localServer);
    print(val);
    List<ElectionStatisticsTime> stats = [];
    if (val == null) {
      return stats;
    }
    try {
      for (var entry in (val['data'] as Map<String, dynamic>).entries) {
        print(entry);
        var time =
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(entry.key, true).toLocal();
        // var time = DateTime.parse(entry.key).toLocal();
        var votes = entry.value;
        stats.add(ElectionStatisticsTime(time: time, votes: votes));
      }
      return stats;
    } catch (err) {
      return [];
    }
  }

  Future<bool> castVote({required String electionId}) async {
    try {
      var val = await postCall('/api/election/add-vote/',
          {'election': electionId}, SystemConfig.localServer);
      print(val);
      if (val == null) {
        return false;
      }
      return true;
    } catch (err) {
      Global.logger.e("An error occured while adding vote to db : $err");
      return false;
    }
  }

  Future<String?> getAccessKey(
      {required String scope, required String clientId}) async {
    try {
      var val = await postCall('/api/user/app/get-accesskey/',
          {'scope': scope, 'clientId': clientId}, SystemConfig.localServer);
      print(val);
      if (val == null) {
        return null;
      }
      try {
        var accessKey = val['data']['access_key'];
        return accessKey;
      } catch (err) {
        return null;
      }
    } catch (err) {
      Global.logger.e("An error occured while getting system configs : $err");
      return null;
    }
  }
}
