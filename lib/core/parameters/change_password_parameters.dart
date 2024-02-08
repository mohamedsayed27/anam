class ChangePasswordParameters {
  final String? currentPassword;
  final String? newPassword;
  final String? confirmPassword;

  ChangePasswordParameters({
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
  });

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = newPassword;
    data['current_password'] = currentPassword;
    data['password_confirmation'] = confirmPassword;
    return data;
  }
}
