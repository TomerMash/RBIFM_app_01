// {notification: {title: Push 7, body: Cool}, data: {url: https://google.com, click_action: FLUTTER_NOTIFICATION_CLICK}}
class NotificationObject {
  Notification notification;

  NotificationObject({
    this.notification,
  });

  factory NotificationObject.fromJson(Map<String, dynamic> json) {
    return NotificationObject(
        notification: Notification.fromJson(json["notification"]));
  }
}

class Notification {
  String title;
  String body;
  CustomData data;

  Notification({this.title, this.body, this.data});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json["title"] as String,
      body: json["body"] as String,
      data: CustomData.fromJson(json["data"])
    );
  }
}

class CustomData {
  String url;

  CustomData({this.url});

  factory CustomData.fromJson(Map<String, dynamic> json) {
    return CustomData(
      url: json["url"] as String,
    );
  }
}
