import 'package:flutter/material.dart';

class TopImage extends StatelessWidget {
  const TopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 70,
      child: ClipOval(
        child: Image.network(
            "https://anazonya.com/wp-content/uploads/2022/03/nuox-2.jpg"),
      ),
    );
  }
}
