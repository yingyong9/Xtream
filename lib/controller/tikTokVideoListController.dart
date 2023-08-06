import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:xstream/models/video_model.dart';

typedef LoadMoreVideo = Future<List<VPVideoController>> Function(
  int index,
  List<VPVideoController> list,
);


class TikTokVideoListController extends ChangeNotifier {
  TikTokVideoListController({
    this.loadMoreCount = 1,
    this.preloadCount = 2,

   
    this.disposeCount = 0,
  });

  
  final int loadMoreCount;

  
  final int preloadCount;

  
  final int disposeCount;

  
  LoadMoreVideo? _videoProvider;

  loadIndex(int target, {bool reload = false}) {
    if (!reload) {
      if (index.value == target) return;
    }
    
    var oldIndex = index.value;
    var newIndex = target;

    
    if (!(oldIndex == 0 && newIndex == 0)) {
      playerOfIndex(oldIndex)?.controller.seekTo(Duration.zero);
      // playerOfIndex(oldIndex)?.controller.addListener(_didUpdateValue);
      // playerOfIndex(oldIndex)?.showPauseIcon.addListener(_didUpdateValue);
      playerOfIndex(oldIndex)?.pause();
      print('暂停$oldIndex');
    }
   
    playerOfIndex(newIndex)?.controller.addListener(_didUpdateValue);
    playerOfIndex(newIndex)?.showPauseIcon.addListener(_didUpdateValue);
    playerOfIndex(newIndex)?.play();
    print('$newIndex');
    
    for (var i = 0; i < playerList.length; i++) {
     
      /// i < newIndex - disposeCount 向下滑动时释放视频
      /// i > newIndex + disposeCount 向上滑动，同时避免disposeCount设置为0时失去视频预加载功能
      if (i < newIndex - disposeCount || i > newIndex + max(disposeCount, 2)) {
        print('释放$i');
        playerOfIndex(i)?.controller.removeListener(_didUpdateValue);
        playerOfIndex(i)?.showPauseIcon.removeListener(_didUpdateValue);
        playerOfIndex(i)?.dispose();
        continue;
      }
     
      if (i > newIndex && i < newIndex + preloadCount) {
        print('$i');
        playerOfIndex(i)?.init();
        continue;
      }
    }
   
    if (playerList.length - newIndex <= loadMoreCount + 1) {
      _videoProvider?.call(newIndex, playerList).then(
        (list) async {
          playerList.addAll(list);
          notifyListeners();
        },
      );
    }

    
    index.value = target;
  }

  _didUpdateValue() {
    notifyListeners();
  }

 
  VPVideoController? playerOfIndex(int index) {
    if (index < 0 || index > playerList.length - 1) {
      return null;
    }
    return playerList[index];
  }


  int get videoCount => playerList.length;

  
  init({
    required PageController pageController,
    required List<VPVideoController> initialList,
    required LoadMoreVideo videoProvider,
  }) async {
    playerList.addAll(initialList);
    _videoProvider = videoProvider;
    pageController.addListener(() {
      var p = pageController.page!;
      if (p % 1 == 0) {
        loadIndex(p ~/ 1);
      }
    });
    loadIndex(0, reload: true);
    notifyListeners();
  }

  
  ValueNotifier<int> index = ValueNotifier<int>(0);

 
  List<VPVideoController> playerList = [];

  ///
  VPVideoController get currentPlayer => playerList[index.value];

 
  void dispose() {
  
    for (var player in playerList) {
      player.showPauseIcon.dispose();
      player.dispose();
    }
    playerList = [];
    super.dispose();
  }
}

typedef ControllerSetter<T> = Future<void> Function(T controller);
typedef ControllerBuilder<T> = T Function();


abstract class TikTokVideoController<T> {
 
  T? get controller;

 
  ValueNotifier<bool> get showPauseIcon;

 
  Future<void> init({ControllerSetter<T>? afterInit});

  
  Future<void> dispose();

 
  Future<void> play();

 
  Future<void> pause({bool showPauseIcon = false});
}


Completer<void>? _syncLock;

class VPVideoController extends TikTokVideoController<VideoPlayerController> {
  VideoPlayerController? _controller;
  ValueNotifier<bool> _showPauseIcon = ValueNotifier<bool>(false);

  final VideoModel? videoInfo;

  final ControllerBuilder<VideoPlayerController> _builder;
  final ControllerSetter<VideoPlayerController>? _afterInit;
  VPVideoController({
    this.videoInfo,
    required ControllerBuilder<VideoPlayerController> builder,
    ControllerSetter<VideoPlayerController>? afterInit,
  })  : this._builder = builder,
        this._afterInit = afterInit;

  @override
  VideoPlayerController get controller {
    if (_controller == null) {
      _controller = _builder.call();
    }
    return _controller!;
  }

  bool get isDispose => _disposeLock != null;
  bool get prepared => _prepared;
  bool _prepared = false;

  Completer<void>? _disposeLock;

  
  Future<void> _syncCall(Future Function()? fn) async {
   
    var lastCompleter = _syncLock;
    var completer = Completer<void>();
    _syncLock = completer;
   
    await lastCompleter?.future;
    
    await fn?.call();
   
    completer.complete();
  }

  @override
  Future<void> dispose() async {
    if (!prepared) return;
    _prepared = false;
    await _syncCall(() async {
      print('+++dispose ${this.hashCode}');
      await this.controller.dispose();
      _controller = null;
      print('+++==dispose ${this.hashCode}');
      _disposeLock = Completer<void>();
    });
  }

  @override
  Future<void> init({
    ControllerSetter<VideoPlayerController>? afterInit,
  }) async {
    if (prepared) return;
    await _syncCall(() async {
      print('+++initialize ${this.hashCode}');
      await this.controller.initialize();
      await this.controller.setLooping(true);
      afterInit ??= this._afterInit;
      await afterInit?.call(this.controller);
      print('+++==initialize ${this.hashCode}');
      _prepared = true;
    });
    if (_disposeLock != null) {
      _disposeLock?.complete();
      _disposeLock = null;
    }
  }

  @override
  Future<void> pause({bool showPauseIcon = false}) async {
    await init();
    if (!prepared) return;
    if (_disposeLock != null) {
      await _disposeLock?.future;
    }
    await this.controller.pause();
    _showPauseIcon.value = true;
  }

  @override
  Future<void> play() async {
    await init();
    if (!prepared) return;
    if (_disposeLock != null) {
      await _disposeLock?.future;
    }
    await this.controller.play();
    _showPauseIcon.value = false;
  }

  @override
  ValueNotifier<bool> get showPauseIcon => _showPauseIcon;
}
