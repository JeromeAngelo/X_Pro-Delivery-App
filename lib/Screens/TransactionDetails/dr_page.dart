import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';

import 'dart:typed_data';

class DrPage extends StatefulWidget {
  const DrPage({super.key});

  @override
  State<DrPage> createState() => _DrPageState();
}

class _DrPageState extends State<DrPage> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  final List<File> _capturedImages = [];

  final PdfViewerController _pdfViewerController = PdfViewerController();
  PdfPageFormat _selectedPageFormat = PdfPageFormat.a4;

  bool _isLandscape = false;

  void _changeOrientation(bool isLandscape) {
    setState(() {
      _isLandscape = isLandscape;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Receipt Delivery Number",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.surface)),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildPdfViewer(),
                  _buildPdfOptions(),
                ],
              ),
            ),
          ),
          Positioned(
              left: 0, right: 0, bottom: 0, child: _buildConfirmButton()),
        ],
      ),
    );
  }

  Widget _buildPdfViewer() {
    return SizedBox(
      height: 450,
      child: SfPdfViewer.asset(
        'pdf/sample.pdf',
        controller: _pdfViewerController,
        enableDoubleTapZooming: true,
        canShowPageLoadingIndicator: true,
        canShowScrollHead: true,
        enableTextSelection: false,
        canShowPaginationDialog: false,
        enableDocumentLinkAnnotation: false,
        pageLayoutMode: _isLandscape
            ? PdfPageLayoutMode.single
            : PdfPageLayoutMode.continuous,
      ),
    );
  }

  Widget _buildPdfOptions() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () async {
                await Printing.layoutPdf(onLayout: (_) async {
                  final bytes = await _pdfViewerController.saveDocument();
                  return Uint8List.fromList(bytes);
                });
              },
              icon: Icon(
                Icons.print,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            IconButton(
              onPressed: () async {
                final bytes = await _pdfViewerController.saveDocument();
                final file = XFile.fromData(Uint8List.fromList(bytes),
                    name: 'receipt.pdf');
                await Share.shareXFiles([file], text: 'Sharing receipt');
              },
              icon: Icon(
                Icons.share,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            DropdownButton<PdfPageFormat>(
              dropdownColor: Theme.of(context).colorScheme.onSurface,
              iconEnabledColor: Theme.of(context).colorScheme.surface,
              value: _selectedPageFormat,
              items: [PdfPageFormat.a4, PdfPageFormat.letter].map((format) {
                return DropdownMenuItem<PdfPageFormat>(
                  value: format,
                  child: Text(
                    format == PdfPageFormat.a4 ? 'A4' : 'Letter',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.surface),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPageFormat = value!;
                });
              },
            ),
            IconButton(
              color: !_isLandscape
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.outlineVariant,
              icon: const Icon(Icons.stay_current_portrait),
              onPressed: () => _changeOrientation(false),
            ),
            IconButton(
              color: _isLandscape
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.outlineVariant,
              icon: const Icon(Icons.stay_current_landscape),
              onPressed: () => _changeOrientation(true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      color: Theme.of(context).colorScheme.surface,
      child: ElevatedButton(
        onPressed: _showBottomModal,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long,
                color: Theme.of(context).colorScheme.onPrimary),
            const SizedBox(width: 8),
            Text(
              'Confirm Receipt',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomModal() {
    showModalBottomSheet(
      showDragHandle: true,
      enableDrag: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 15,
              right: 15,
              top: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSignaturePad(),
                _buildNameField(),
                const SizedBox(height: 15),
                _buildCameraButton(),
                const SizedBox(height: 15),
                _buildImageGallery(),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _navigateToNextPage();
                    },
                    icon: const Icon(Icons.done),
                    label: Text(
                      'Done',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    )),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSignaturePad() {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).colorScheme.outline))),
          child: SfSignaturePad(
            key: _signaturePadKey,
            backgroundColor: const Color.fromARGB(40, 199, 199, 199),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Text(
            'Sign Here',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(context).colorScheme.outline),
          ),
        ),
        Positioned(
          bottom: 3,
          right: 8,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.cancel_outlined,
                    color: Theme.of(context).colorScheme.primary),
                onPressed: _resetSignature,
              ),
              Text(
                'Cancel',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
          labelText: 'Enter your name',
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          alignLabelWithHint: true,
          focusColor: Theme.of(context).colorScheme.primary,
          filled: true,
          fillColor: const Color.fromARGB(40, 199, 199, 199)),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  void _resetSignature() {
    _signaturePadKey.currentState?.clear();
  }

  Future<void> _takePicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _capturedImages.add(File(photo.path));
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _capturedImages.removeAt(index);
    });
  }

  void _navigateToNextPage() {
    if (_nameController.text.isEmpty ||
        _signaturePadKey.currentState?.toImage() == null ||
        _capturedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(
              'Please fill all required fields and take at least one picture.',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.surface),
            )),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(milliseconds: 1000),
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: Text(
              'Transaction Completed.',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.surface),
            )),
      );
      context.push('/delivery-and-invoice');
    }
  }

  Widget _buildCameraButton() {
    return ElevatedButton.icon(
        onPressed: _takePicture,
        label: const Text('Take Picture'),
        icon: const Icon(Icons.camera_alt_outlined));
  }

  Widget _buildImageGallery() {
    return _capturedImages.isEmpty
        ? const SizedBox.shrink()
        : GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _capturedImages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Center(
                    child: Image.file(
                      _capturedImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: -8,
                    right: -5,
                    child: IconButton(
                      icon: Icon(Icons.close,
                          color: Theme.of(context).colorScheme.error),
                      onPressed: () => _deleteImage(index),
                    ),
                  ),
                ],
              );
            },
          );
  }
}
