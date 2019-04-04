import 'package:flutter/material.dart';
import 'package:Inke/config/app_config.dart';


typedef void OnPickPhotoCallBack();
typedef void OnPickGalleryCallBack();

class BottomPhotoView extends StatelessWidget {

  final OnPickPhotoCallBack _photoCallBack;
  final OnPickGalleryCallBack _galleryCallBack;

  BottomPhotoView(this._photoCallBack,this._galleryCallBack);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
            child: Center(
              child: Text(
                '拍照',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            _photoCallBack();
            //pickHeader(ImageSource.camera);
            Navigator.of(context).pop();
          },
        ),
        Divider(
          height: 1.0,
          color: Color(AppColors.windowBackground),
        ),
        InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
            child: Center(
              child: Text(
                '从相册选取',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            _galleryCallBack();
            //pickHeader(ImageSource.gallery);
            Navigator.of(context).pop();
          },
        ),
        Divider(
          height: 1.0,
          color: Color(AppColors.windowBackground),
        ),
        InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
            child: Center(
              child: Text(
                '取消',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
