import 'package:dio/dio.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherMethods {
  late PusherChannelsFlutter pusher;

  PusherMethods({
    required this.pusher,
  });

  onAuthorizer(String channelName, String socketId, dynamic options) async {
    try {
      print("$channelName: $socketId");
      final response = await Dio(BaseOptions(
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'User-Agent': 'Chrome/96.0.4664.110',
          'Cookie' : 'XSRF-TOKEN=eyJpdiI6IloxQnVGNm40ZHJDR1pNcXVTYkFLdnc9PSIsInZhbHVlIjoiSFFKQitzQnJhK0p5QWxYU0g2RWk0UGRENHJDK2dOZERta09yK0ZqSWdLS2tPbjhVKzF4RDZuL2Z4andtZ1BuVmRQUWVHdlJpMmpVLzJ5L0pWaGNpN1RmRWsyellJb09YVklTZitmdWVjVjF1RHhRQ2s5OURnUWcvaHk0cEJQaGIiLCJtYWMiOiJmMDQyM2RmMDU3OGU4YTQ1Y2ZjNmMzYTZkMDU2NDFiNThjODcxZWEzYjZlMDk3OTMxYjQ5MTg0MjY4NmQxMzQ1IiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ik5XdTlXSkhLVndGVXIwcStSa2xmZkE9PSIsInZhbHVlIjoiVFlMQmNLM0NDOWZTZHlPWVpjRVFXVm8rY3g2WTBjbkdQV3ZUMWczNk56czR2RnFveW5XTXMyUzZPMk8xZkYyNUhMUHJ2alphNEI0amtsMGFRT0g3REczNE54eFZGQW4zcHZMQS8yQm9XMUFrVlF3UjVHM2tJSUxJNlZna1lGL20iLCJtYWMiOiI5MDk2YTJmMzY0MGU5MGMyNDhmNzVkNmE0ZDRmOTFmNGYyZTQ4YWUzYjc1NTllMDUwZmJhODdkMmI5ZmViZGNiIiwidGFnIjoiIn0%3D',
        },
      )).post(
        "https://ban3am.com/broadcasting/auth",
        data: {
          "socket_id": socketId,
          "channel_name": channelName,
          // Add any other relevant data for authorization
        },
      );
      print(response.statusCode);
      print(response.data);
      // final jsonResponse = jsonDecode(response.data);
      if (response.statusCode == 200 && response.data["auth"] != null) {
        return response.data; // Return the authorization token
      } else {
        print("Error during authorization: ${response.statusCode}");
        return null; // Authorization failed
      }
    } catch (e) {
      print("Error during authorization: $e");
      return null;
    }
  }

  void channelSubscription({
    required int receiverId,
    required int senderId,
    dynamic Function(PusherEvent)? onEvent,
    dynamic Function(String, dynamic)? onSubscriptionError,
    dynamic Function(String, String)? onConnectionStateChange,
    dynamic Function(String, PusherMember)? onMemberRemoved,
    dynamic Function(String, dynamic)? onSubscriptionSucceeded,
  }) async {
    final list = <int>[receiverId, senderId]..sort();
    try {
      await pusher.init(
        apiKey: "d7e9da7b3bc9de6317b3",
        cluster: "eu",
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onConnectionStateChange: onConnectionStateChange,
        onMemberRemoved: onMemberRemoved,
      );

      await pusher.subscribe(channelName: "private.chat.${list.join(".")}");
      await pusher.connect();
    } catch (e) {
      print("Error : ${e}");
    }
  }
}

void onEvent(PusherEvent event) {
  print("onEvent: $event");
}
