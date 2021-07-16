import 'dart:io' as io;
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:new_ecom_project/core/flutter_bloc/event/GetDetailTripEvent.dart';
import 'package:new_ecom_project/core/flutter_bloc/state/GetTripDetailState.dart';
import 'package:new_ecom_project/core/model/detailTripData/detailTripData.dart';
import 'package:path_provider/path_provider.dart' as pat;
import 'package:new_ecom_project/core/services/repository.dart';

class GetDetailTripBloc extends Bloc<DetailTripEvent, GetDetailTripState> {
  final _repository = Repository();

  @override
  GetDetailTripBloc() : super(GetDetailTripInitial());
  Stream<GetDetailTripState> mapEventToState(DetailTripEvent event) async* {
    if (event is GetDetailTripEvent) {
      deleteCacheImage();
      List<String> listImage = [];
      var imageObj;
      List<String> imageLinkList = [];
      try {
        if (event is GetDetailTripEvent) {
          yield GetDetailTripLoading();
          isolatePort();
          var result;

          await _repository.getDetailTrip(event.tripCode).then((value) {
            print(
                'value.imageLink.length.' + value.imageLink.length.toString());

            result = value;

            imageLinkList = result.imageLink;
            print('imageLinkList.length.' + imageLinkList.length.toString());
          }).catchError((error) {
            print(error);
            throw Exception(error);
          });

          await saveImageToDevice(imageLinkList).then((value) {
            print('DONE');
          }).catchError((err) {
            throw Exception(err);
          });
          await getCacheImage()
              .then((value) => result.imagePath = value)
              .catchError((err) {
            throw Exception(err);
          });
          print(result.imagePath.toString());
          print(
              'result.imagePath.length.' + result.imagePath.length.toString());
          yield GetDetailTripSuccess(trip: result, isloading: true);
        }
      } catch (exception) {
        yield GetDetailTripError(exception.toString());
      }
    }
    if (event is GetLoadingStatus && state is GetDetailTripSuccess) {
      getCacheImage().then(
          (value) => (state as GetDetailTripSuccess).trip.imagePath = value);
      bool result = false;
      result = (state as GetDetailTripSuccess).trip.imageLink.length ==
              (state as GetDetailTripSuccess).trip.imagePath.length
          ? false
          : true;
      yield GetDetailTripSuccess(
          trip: (state as GetDetailTripSuccess).trip, isloading: result);
    }
    return;
  }

  Future saveImageToDevice(List<String> linkList) async {
    print("linkList.length......." + linkList.length.toString());

    final dir = await pat.getTemporaryDirectory();
    print(dir.path);
    io.Directory(dir.path + "/tripImage")
        .create()
        .then((value) => print(value.path));
    List<String> fileList = [];
    print("2");
    await downloadProcess(linkList, dir.path + "/tripImage/").then((value) {
      print("Bua nay tai duoc toi $value anh");
    });
    // List<io.FileSystemEntity> fileSysList =
    //     io.Directory(dir.path + "/tripImage/").listSync();
    // print("fileSysList.length" + fileSysList.length.toString());
    // for (var element in fileSysList) {
    //   fileList.add(element.path);
    // }
    // return fileList;
  }

  static isolatePort() {
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      print("RCV" + id + " " + status.toString() + " " + progress.toString());
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    // if (status.toString() == 'DownloadTaskStatus(3)') {
    print(id + " " + status.toString() + " " + progress.toString());
    // }
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  static deleteCacheImage() async {
    final dir = await pat.getTemporaryDirectory();
    List<io.FileSystemEntity> deleteList =
        io.Directory(dir.path + "/tripImage/").listSync();
    for (var element in deleteList) {
      element.delete();
    }
  }

  Future<List<String>> getCacheImage() async {
    List<String> fileList = [];
    final dir = await pat.getTemporaryDirectory();
    List<io.FileSystemEntity> deleteList =
        io.Directory(dir.path + "/tripImage/").listSync();
    for (var element in deleteList) {
      fileList.add(element.path);
    }
    return fileList;
  }

  Future downloadProcess(List<String> linkList, String dir) async {
    int i = 0;
    for (var link in linkList) {
      print("Process $i");
      FlutterDownloader.enqueue(
        url: link,
        savedDir: dir,
        openFileFromNotification: false,
        showNotification: false,
      ).then((value) => print(value)).onError((error, stackTrace) {
        return Future.error(error.toString(), stackTrace);
      });

      i++;
    }
    return i;
  }
}
