import 'package:flutter/material.dart';

class VotesCounter extends StatefulWidget {
  final counter;

  VotesCounter(this.counter);
  @override
  _VotesCounterState createState() => _VotesCounterState(this.counter);
}

class _VotesCounterState extends State<VotesCounter> {
  int _counter;
  int _initialCounter = 0;

  _VotesCounterState(this._counter);

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: () {
        /* getState.addLikeToTweet(
         getModel, authStateFalse?.userId); */
      },
      child:
          Column(
        children: [
          GestureDetector(
            onTap: _initialCounter < _counter ? _resetCounter : _incrementCounter,
            child: Icon(
              Icons.arrow_drop_up_outlined,
              size: 35,
              color: _initialCounter < _counter ? Colors.green : Colors.black,
            ),
          ),
          Text(
            this._counter.toString(),
            style: TextStyle(fontSize: 18, color: _getCounterColor()),
          ),
          GestureDetector(
            onTap:  _initialCounter > _counter ? _resetCounter : _decrementCounter,
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 35,
              color: _initialCounter > _counter ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialCounter = _counter;
  }

  Color _getCounterColor() {
    if(_counter > 0) return Colors.green;
    if(_counter < 0) return Colors.red;
    return Colors.black;
  }

  void _incrementCounter() {
    setState(() {
      _initialCounter >= _counter ? _counter++ : _counter = _counter;

    });
  }

  void _decrementCounter() {

    setState(() {
      _initialCounter <= _counter ? _counter-- : _counter = _counter;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = _initialCounter;
    });
  }

}
