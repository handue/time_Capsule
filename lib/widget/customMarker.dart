import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class customMarker {
  // infoWindow도 나중에 마커 넣을 때 해야함.
  // infoWindow는 마커 눌렀을 때 정보같은거 뜨도록 하는거

  static Future<ui.Image> getImageFromPath(String imagePath) async {
    // File imageFile = File(imagePath);
    // Uint8List bytes = imageFile.readAsBytesSync();
    //// 위에 이거는 imagepicker마냥 사용자한테 이미지 받아올 때 쓰는거,

    ByteData data = await rootBundle.load(imagePath);
    // rootbundle은 앱에 포함된 자산들을 가져올 때 쓰는거라, 나중에 서버로부터 가져오도록 해야함.
    Uint8List bytes = data.buffer.asUint8List();
    final Completer<ui.Image> completer = Completer();

    ui.decodeImageFromList(bytes, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future; // completer는 비동기 작업의 결과를 future로 반환할 때 사용
    // 즉 Completer<ui.Image>는 ui.Image타입의 결과를 나중에 받을 Future를 생성하는 거 .
    // 그니까 Completer() 라는 객체를 만들어서, ui.Image라는 객체의 값을 future로 변환하고자 사용.
    // 그럼 completer.future은 Completer에 의해 생성된 future 객체를 반환.
    //completer.future는 비동기 작업이 완료될 때까지 기다리는 Future를 반환.
    // completer 사용하면 기존에 콜백 형태로 작동하는 거를 future로 변환 가능
    // 일단 위에 비동기 작업이 안 끝나면 우선적으로 competer.future 반환, 이후에 위 작업 끝나면 complete(img)하는것
  }

  static Future<BitmapDescriptor> getMarkerIcon(
      String imagePath, Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    //이 picutrerecorder는 그래픽 작업을 순차적으로 기록하는 클래스. 이를 통해 복잡한 그래픽 구성하고
    // 나중에 이를 이미지나 다른 미디어로 렌더링 가능
    // 보통 Canvas에 전달해서 연결해야 그래픽 작업 기록이 가늫아다네
    final Canvas canvas = Canvas(pictureRecorder);
    // Canvas는 flutter에서 그래픽 작업을 기록하는 인터페이스.
    // Canvas객체는 Picture 객체 생성에 사용되며, 이 picture는 scenebuilder와 함꼐 사용됨.
    //즉 canvas는 그림을 그리고 이를 picture로 변환하여 ui에 표시하는 거
    // canvas 객체를 생성할 때는 picturerecorder 객체가 꼭 필요. 이와 같은 형태는 필수

    final Radius radius = Radius.circular(size.width / 2);

    final Paint tagPaint = Paint()..color = Colors.blue;
    const double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = Colors.blue.withAlpha(100);
    const double shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    const double borderWidth = 3.0;

    const double imageOffset = shadowWidth + borderWidth;
    //아 이게 shadow랑 border의 반경 안에다가 image 넣으려고 하는거인듯
    // 그게 아니었음. shadow랑 border를 적절하게 image툴에다가 다 넣으려고 image 툴을 가장 크게 하는거
    // image 툴이 가장 커야 shadow, border가 다 이미지에 적용될테니/
    //Paint는 flutter에서 그리기 작업할 때 사용
    // .. 이거는 동일한 객체에 대해 연속적인 작업 수행하도록 하는것
    // 즉 Paint TagPaint = Paint();, TagPaint.color = Colors.blue;

    canvas.drawRRect(
        //위 명령어는 캔버스 위에 둥근 모서리의 직사각형을 그리는 것
        RRect.fromRectAndCorners(
          //둥근 모서리를 가진 직사각형을 나타내는 객체, style 같은거라고 보면 될듯
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          //왼쪽, 위,width,height 설정
          //근데 여기서 왼쪽이랑 위는 좌표 값을 나타내는 것인데, 시작 점에서 왼쪽 위가 0, 그냥 위도 0이라는 좌표에서 시작하는것.
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);
    //shadowPaint는 둥근 모서리 직사각형을 그릴 때 사용되는 Paint 객체. 위에 저장해놓은 shadowPaint 방식으로 위에 해당하는 둥근 모서리 직사각형을 그리는거.
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(
                shadowWidth,
                shadowWidth,
                size.width - (shadowWidth * 2),
                size.height - (shadowWidth * 2)),
            topLeft: radius,
            topRight: radius,
            bottomLeft: radius,
            bottomRight: radius),
        borderPaint);

    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(size.width - tagWidth, 0.0, tagWidth, tagWidth),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        tagPaint);
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    //textDirection -> ltr 은 left to right, 즉 왼쪽에서 오른쪽으로 그리는거
    textPainter.text = const TextSpan(
      text: '1',
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );

    textPainter.layout();
    // TextPainter 객체를 사용할 때는, 일반적으로 먼저 layout 메서드를 호출하여 텍스트의 레이아웃을 계싼하면 됨.
    // 그 다음 paint 메서드 사용, 이 두 개는 꼭 같이.
    // textPainter.layout(); 을 통해서 주어진 텍스트와 스타일을 바탕으로 텍스트가 차지할
    // 공간의 크기(너비와 높이)를 결정하는것. 그냥 textPainter.paint 할 때의 텍스트의 크기를 계산하는데 필요한거
    // 위 paint는 textPainter.text, 즉 위에 정의해놓는거 그릴 때 쓰는거. canvas는 도구
    textPainter.paint(
        canvas,
        Offset(size.width - tagWidth / 2 - textPainter.width / 2,
            tagWidth / 2 - textPainter.height / 2));

    // 이 Offset은 뭐지 이해가 안돼 ㅋㅋㅋ
    // Rect 사각형 그리는거임.
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size.width - (imageOffset * 2), size.height - (imageOffset * 2));
    canvas.clipPath(Path()..addOval(oval));
    //canvas에서 클리핑 영역 설정하는 거. 그니까 지정된 경로나 모양 안쪽의 부분만 그리고 나머지 부분은 자르는거
    // clip.hardEdge 할 때 clip 같은거
    // 이 메소드를 호출한 후 캔버스에 그리는 모든 내용은 이 경로 내부에만 그려진대.
    // addOval은 이전에 정의된 oval 사각형에 내정하는 타원형 경로를 현재 경로에 추가.
    // oval 사각형은 타원의 경계를 정의하는 거, 그니까 Rect oval 안에 타원형 경로가 있는거임.

    // Add image
    //여기부턴 내일 다시 공부해야함
    ui.Image image = await getImageFromPath(
        imagePath); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final ByteData? byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }
}
