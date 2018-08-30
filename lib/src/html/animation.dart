part of universal_html;

abstract class Animation {
  factory Animation(
      [AnimationEffectReadOnly effect, AnimationTimeline timeline]) {
    throw UnimplementedError();
  }

  void cancel();

  void finish();

  void pause();

  void play();

  void reverse();
}

abstract class AnimationEffectReadOnly {}

abstract class AnimationEffect extends AnimationEffectReadOnly {
  num delay;
  String direction;
  Object duration;
  String easing;
  num endDelay;
  String fill;
  num iterations;
  num iterationStart;
}

abstract class AnimationTimeline {
  num get currentTime;
}

abstract class DocumentTimeline extends AnimationTimeline {
  factory DocumentTimeline([Map options]) {
    throw UnimplementedError();
  }

  @override
  num get currentTime;
}

abstract class ScrollTimeline extends AnimationTimeline {
  factory ScrollTimeline([Map options]) {
    throw UnimplementedError();
  }

  @override
  num get currentTime;
}
