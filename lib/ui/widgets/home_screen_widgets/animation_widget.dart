import 'package:flutter/material.dart';

class AnimatedLogoWidget extends StatefulWidget {
  const AnimatedLogoWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedLogoWidget> createState() => _AnimatedLogoWidgetState();
}

class _AnimatedLogoWidgetState extends State<AnimatedLogoWidget>   with SingleTickerProviderStateMixin  {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))
        ..repeat(reverse: true);

  late final Animation<Offset> _animation =
      Tween<Offset>(begin: Offset.zero, end: const Offset(0, 0.15))
          .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
                  position: _animation,
                  child: Stack(
                    children: [
                       Padding(
                         padding: const EdgeInsets.only(top:2.0,left: 4.0),
                         child: Image.asset(
                          "asset/image/logo-whatsapp.png",
                          color: Colors.black.withOpacity(0.6),
                          width: 60,
                      ),
                       ),
                      Image.asset(
                        "asset/image/logo-whatsapp.png",
                        width: 60,
                      ),
                    ],
                  ),
                );
  }
}