import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

/// {@template profile_image}
/// Show an [CircleAvatar] with the given [imageURL].
///
/// If [imageURL] in null [firstName] and/or [lastName] will be used to
/// generate initials to be show in the [CircleAvatar].
///
/// Atleast on of [imageURL], [firstName] or [lastName] should not be null.
/// {@endtemplate}
class ProfileImage extends StatelessWidget {
  /// Network URL for the image to be shown
  final String imageURL;

  /// First Name of the person
  final String firstName;

  /// Last Name of the person
  final String lastName;

  /// Same as [CircleAvatar.backgroundColor]
  final Color backgroundColor;

  /// Same as [CircleAvatar.foregroundColor]
  final Color foregroundColor;

  /// Same as [CircleAvatar.radius]
  final double radius;

  /// Same as [CircleAvatar.minRadius]
  final double minRadius;

  /// Same as [CircleAvatar.maxRadius]
  final double maxRadius;

  /// Same as [Text.style]
  final TextStyle style;

  /// {@macro profile_image}
  ProfileImage({
    Key key,
    this.imageURL,
    this.firstName,
    this.lastName,
    this.backgroundColor,
    this.foregroundColor,
    this.radius,
    this.minRadius,
    this.maxRadius,
    this.style,
  })  : assert(firstName != null || lastName != null || imageURL != null),
        super(key: key);

  String _generate() {
    if (firstName == null) {
      return lastName.substring(1, 3);
    }
    if (lastName == null) {
      return firstName.substring(1, 3);
    }
    return '${firstName[0]}${lastName[0]}';
  }

  @override
  Widget build(BuildContext context) {
    final noImg = imageURL == null || imageURL.trim().isEmpty;
    final initials = noImg ? _generate().toUpperCase() : '';

    return CircleAvatar(
      backgroundImage: noImg ? null : AdvancedNetworkImage(imageURL),
      child: noImg
          ? Text(
        initials,
        style: style,
        maxLines: 1,
        textAlign: TextAlign.center,
      )
          : null,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      radius: radius,
      maxRadius: maxRadius,
      minRadius: minRadius,
    );
  }
}
