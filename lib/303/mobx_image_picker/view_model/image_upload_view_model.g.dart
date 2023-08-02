// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_upload_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ImageUploadViewModel on ImageUploadViewModelBase, Store {
  late final _$fileAtom =
      Atom(name: 'ImageUploadViewModelBase.file', context: context);

  @override
  File? get file {
    _$fileAtom.reportRead();
    return super.file;
  }

  @override
  set file(File? value) {
    _$fileAtom.reportWrite(value, super.file, () {
      super.file = value;
    });
  }

  late final _$imageUrlAtom =
      Atom(name: 'ImageUploadViewModelBase.imageUrl', context: context);

  @override
  String get imageUrl {
    _$imageUrlAtom.reportRead();
    return super.imageUrl;
  }

  @override
  set imageUrl(String value) {
    _$imageUrlAtom.reportWrite(value, super.imageUrl, () {
      super.imageUrl = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ImageUploadViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$downloadTextAtom =
      Atom(name: 'ImageUploadViewModelBase.downloadText', context: context);

  @override
  String get downloadText {
    _$downloadTextAtom.reportRead();
    return super.downloadText;
  }

  @override
  set downloadText(String value) {
    _$downloadTextAtom.reportWrite(value, super.downloadText, () {
      super.downloadText = value;
    });
  }

  late final _$ImageUploadViewModelBaseActionController =
      ActionController(name: 'ImageUploadViewModelBase', context: context);

  @override
  void changeLoading() {
    final _$actionInfo = _$ImageUploadViewModelBaseActionController.startAction(
        name: 'ImageUploadViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$ImageUploadViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void uploadImageUrl(ImageUploadResponse? response) {
    final _$actionInfo = _$ImageUploadViewModelBaseActionController.startAction(
        name: 'ImageUploadViewModelBase.uploadImageUrl');
    try {
      return super.uploadImageUrl(response);
    } finally {
      _$ImageUploadViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDownloadText(int send, int total) {
    final _$actionInfo = _$ImageUploadViewModelBaseActionController.startAction(
        name: 'ImageUploadViewModelBase.updateDownloadText');
    try {
      return super.updateDownloadText(send, total);
    } finally {
      _$ImageUploadViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveLocalFile(XFile? file) {
    final _$actionInfo = _$ImageUploadViewModelBaseActionController.startAction(
        name: 'ImageUploadViewModelBase.saveLocalFile');
    try {
      return super.saveLocalFile(file);
    } finally {
      _$ImageUploadViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
file: ${file},
imageUrl: ${imageUrl},
isLoading: ${isLoading},
downloadText: ${downloadText}
    ''';
  }
}
