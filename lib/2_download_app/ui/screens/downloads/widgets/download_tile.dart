import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

 // TODO

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context,child) {
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
          child: ListTile(
          title: Text(controller.ressource.name),
          subtitle: _buildSubtitle(),
          trailing: _buildTrailing(),
        ),
        );
      }
      );
  }

  Widget _buildSubtitle(){
    switch(controller.status){
      case DownloadStatus.notDownloaded :
      return Text('');

      case DownloadStatus.downloading :
      final downloadMB = controller.ressource.size * controller.progress;
      return Text('${controller.progress * 100} % completed - ${downloadMB} of ${controller.ressource.size} MB');

      case DownloadStatus.downloaded :
      final downloadMB = controller.ressource.size * controller.progress;
      return Text('${controller.progress * 100} % completed - ${downloadMB} of ${controller.ressource.size} MB');

    }
  }

    Widget _buildTrailing(){
    switch(controller.status){
      case DownloadStatus.notDownloaded :
      return IconButton(
          icon: Icon(Icons.download),
          onPressed: controller.startDownload,
        );

      case DownloadStatus.downloading :
      return Icon(Icons.downloading);

      case DownloadStatus.downloaded :
      return Icon(Icons.download_done);

    }
  }

}
