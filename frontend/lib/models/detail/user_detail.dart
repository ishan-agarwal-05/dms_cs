class UserD {
  final String id;
  final String idStr;
  final String roleId;
  final String username;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String mobile;
  final String password;
  final String status;
  final String isAdmin;
  final String webAccess;
  final String mobileAccess;
  final String lastPasswordChange;
  final String modified;
  final String createdBy;
  final String modifiedBy;
  final String deleted;

  UserD({
    required this.id,
    required this.idStr,
    required this.roleId,
    required this.username,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.password,
    required this.status,
    required this.isAdmin,
    required this.webAccess,
    required this.mobileAccess,
    required this.lastPasswordChange,
    required this.modified,
    required this.createdBy,
    required this.modifiedBy,
    required this.deleted,
  });

  factory UserD.fromJson(Map<String, dynamic> json) {
    return UserD(
      id: json['id']?.toString() ?? '',
      idStr: json['id_str']?.toString() ?? '',
      roleId: json['role_id']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      firstName: json['first_name']?.toString() ?? '',
      middleName: json['middle_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      isAdmin: json['is_admin']?.toString() ?? '',
      webAccess: json['web_access']?.toString() ?? '',
      mobileAccess: json['mobile_access']?.toString() ?? '',
      lastPasswordChange: json['last_password_change']?.toString() ?? '',
      modified: json['modified']?.toString() ?? '',
      createdBy: json['created_by']?.toString() ?? '',
      modifiedBy: json['modified_by']?.toString() ?? '',
      deleted: json['deleted']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_str': idStr,
      'role_id': roleId,
      'username': username,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'password': password,
      'status': status,
      'is_admin': isAdmin,
      'web_access': webAccess,
      'mobile_access': mobileAccess,
      'last_password_change': lastPasswordChange,
      'modified': modified,
      'created_by': createdBy,
      'modified_by': modifiedBy,
      'deleted': deleted,
    };
  }
}