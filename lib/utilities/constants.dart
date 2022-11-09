import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: '',
  fontSize: 30.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'MavenPro',
  fontSize: 36,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'IBM Plex Serif',
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: 30.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: "Enter City Name",
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none,
  ),
);
