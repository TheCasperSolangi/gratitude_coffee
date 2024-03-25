class UserModel {

    String? uid;
    String? email;
    String? firstName;
    String? customer_id;
    String? phoneNumber;
    String? last_name;
    bool? status;
    String? address1;
    String? address2;
    String? city;
    String? user_state;
    String? postalCode;
    String? country_id;
    

UserModel({this.uid,  this.email,  this.firstName, this.customer_id, this.phoneNumber, this.last_name, this.status = true, this.address1, this.address2, this.city, this.user_state,  this.country_id, this.postalCode});

// data from server

factory UserModel.fromMap(map) {
    return UserModel(

        uid: map['uid'],
        email: map['email'],
        firstName: map['first_name'],
        customer_id: map['customer_id'],
        phoneNumber: map['phoneNumber'],
        last_name: map['lastName'],
        status: map[true],
        address1: map['address1'],
        address2: map['address2'],
        city:map['city'],
        user_state: map['state'],
        country_id: map['country_id'],
        postalCode:map['postal_code'],

    );
}

// sending data to our server

Map<String, dynamic> toMap() {
  return {
    'uid': uid,
    'email': email,
    'firstName': firstName,
    	'customer_id': customer_id,
      'phoneNumber': phoneNumber,
      'lastName': last_name,
      'status': true,
      'address1': address1,
      'address2':address2,
      'state': user_state,
      'city': city,
      'postal_code': postalCode,
      'countryId': country_id, 
    };
  }
}


