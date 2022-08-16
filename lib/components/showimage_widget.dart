import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowimageWidget extends StatefulWidget {
  const ShowimageWidget({
    Key? key,
    this.image,
  }) : super(key: key);

  final String? image;

  @override
  _ShowimageWidgetState createState() => _ShowimageWidgetState();
}

class _ShowimageWidgetState extends State<ShowimageWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Hero(
        tag: 'showimage',
        transitionOnUserGestures: true,
        child: Image.network(
          'https://picsum.photos/seed/520/600',
          width: 939,
          height: 1215,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
