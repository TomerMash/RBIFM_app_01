class SideMenuItem {
  final String name;
  final String icon;
  final String action;
  final String type;
  final int menuOrder;

  SideMenuItem({this.name, this.icon, this.action, this.type, this.menuOrder});

  factory SideMenuItem.fromJson(Map<String, dynamic> json) {
    return SideMenuItem(
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      action: json['action'] ?? '',
      type: json['type'],
      menuOrder: json['menu_order'] ?? 0
    );
  }
}
