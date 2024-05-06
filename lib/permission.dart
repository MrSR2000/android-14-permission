import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

class PermissionHandleA14 extends StatefulWidget {
  const PermissionHandleA14({super.key});

  @override
  State<PermissionHandleA14> createState() => _PermissionHandleA14State();
}

class _PermissionHandleA14State extends State<PermissionHandleA14> {
  List<Media> mediaList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: previewList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => openImagePicker(context),
      ),
    );
  }

  Widget previewList() {
    return SizedBox(
      height: 96,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: List.generate(
            mediaList.length,
            (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: mediaList[index].thumbnail == null
                        ? const SizedBox()
                        : Image.memory(
                            mediaList[index].thumbnail!,
                            fit: BoxFit.cover,
                          ),
                  ),
                )),
      ),
    );
  }

  void openImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return MediaPicker(
          mediaList: mediaList,
          onPicked: (selectedList) {
            setState(() => mediaList = selectedList);
            Navigator.pop(context);
          },
          onCancel: () => Navigator.pop(context),
          mediaCount: MediaCount.multiple,
          mediaType: MediaType.all,
          decoration: PickerDecoration(
            blurStrength: 0,
            scaleAmount: 1,
            counterBuilder: (context, index) {
              if (index == null) return const SizedBox();
              return Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
