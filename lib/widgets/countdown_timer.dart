import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int duration;
  final VoidCallback onTimeout;

  CountdownTimer({
    required this.duration,
    required this.onTimeout,
  });

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onTimeout();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: 1 - _controller.value,
                    strokeWidth: 6,
                    backgroundColor: Colors.grey,
                    color: _controller.value > 0.5 ? Colors.green : Colors.red,
                  ),
                ),
                Text(
                  '${(widget.duration * (1 - _controller.value)).round()} s',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
