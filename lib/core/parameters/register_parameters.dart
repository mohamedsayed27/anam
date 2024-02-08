class RegisterParameters {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? password;
  final String? confirmPassword;
  final String? countryId;
  final String? type;

  RegisterParameters({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
    this.confirmPassword,
    this.countryId,
    this.type,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['password_confirmation'] = confirmPassword;
    data['country_id'] = countryId;
    data['type'] = type;
    return data;
  }
}
