import 'package:flutter/material.dart';
import 'package:Inke/config/colors.dart';
import 'package:Inke/widgets/text.dart';

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
                style: TextStyles.blueBold18,
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
          color: AppColors.windowBackground,
        ),
        InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
            child: Center(
              child: Text(
                '从相册选取',
                style: TextStyles.blueBold18,
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
          color: AppColors.windowBackground,
        ),
        InkWell(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
            child: Center(
              child: Text(
                '取消',
                style: TextStyles.redBold18,
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
