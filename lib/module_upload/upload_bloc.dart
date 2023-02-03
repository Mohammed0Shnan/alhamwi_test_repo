import 'package:alhamwi_test/module_upload/enum/image_type.dart';
import 'package:alhamwi_test/module_upload/service/image_upload_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadBloc extends Bloc<UploadEvent, UploadStates> {

  final ImageUploadService _service = ImageUploadService();

  UploadBloc() : super(UploadInitState()) {
    on<UploadEvent>((UploadEvent event, Emitter<UploadStates> emit) {
      if (event is UploadLoadingEvent)
        emit(UploadLoadingState());
      else if (event is UploadErrorEvent) {
        emit(UploadErrorState());
      } else if (event is UploadSuccessEvent) {
        emit(UploadSuccessState(event.image));
      } else {
        emit(UploadInitState());
      }
    });
  }

  Future<void> upload(String res, ImageType imageType) async {
    this.add(UploadLoadingEvent());
    await _service.uploadImage(res, imageType).then((value) {
      if (value != null) {
        this.add(UploadSuccessEvent(value));
      } else
        this.add(UploadErrorEvent());
    });
  }

 pickFile(ImageSource imageSource)  {
   if( state is UploadSuccessState) {
    String _image =  ( state as UploadSuccessState ).image;
    this.add(UploadSuccessEvent(_image));
   }else
    this.add(UploadLoadingEvent());

    _service.getImageFromGallery(imageSource).then((value) {
      if (value != '') {
        this.add(UploadSuccessEvent(value));
      } else
        this.add(UploadErrorEvent());
    });
  }

  initState() {
    add(UploadInitEvent());
  }
}

abstract class UploadEvent {}

class UploadInitEvent extends UploadEvent {}

class UploadSuccessEvent extends UploadEvent {
  String image;
  UploadSuccessEvent(this.image);
}

class UploadLoadingEvent extends UploadEvent {}

class UploadErrorEvent extends UploadEvent {}

abstract class UploadStates {}

class UploadInitState extends UploadStates {}

class UploadSuccessState extends UploadStates {
  String image;
  UploadSuccessState(this.image);
}

class UploadLoadingState extends UploadStates {}

class UploadErrorState extends UploadStates {}
