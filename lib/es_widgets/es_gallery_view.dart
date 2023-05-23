import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:piggy_flow_mobile/es_widgets/es_blurhash_gallery_card.dart';
import 'package:piggy_flow_mobile/es_widgets/es_gallery_card.dart';
import 'package:piggy_flow_mobile/models/bill_photo.dart';

class ESGalleryView extends StatefulWidget {
  ESGalleryView({
    super.key,
    this.loadingBuilder,
    this.initialIndex = 0,
    required this.images,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final int initialIndex;
  final PageController pageController;
  final List<BillPhoto> images;

  @override
  State<StatefulWidget> createState() {
    return _ESGalleryViewState();
  }
}

class _ESGalleryViewState extends State<ESGalleryView> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.images.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: Axis.horizontal,
            ),
            Positioned(
              top: 50,
              right: 16,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    return PhotoViewGalleryPageOptions.customChild(
      child: CachedNetworkImage(
        imageUrl:
            '${dotenv.env['API_URL']}/bill/getPhoto/${widget.images[index].path}',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
            ),
          ),
        ),
        placeholder: (context, url) => widget.images[index].blurhash != null
            ? ESBlurhashGalleryCard(
                blurhash: widget.images[index].blurhash!,
              )
            : const ESGalleryCard(
                child: CircularProgressIndicator(color: Colors.white),
              ),
        errorWidget: (context, url, error) => const ESGalleryCard(
          child: Icon(Icons.error),
        ),
      ),
      childSize: const Size(300, 300),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes:
          PhotoViewHeroAttributes(tag: widget.images[index].id ?? 0),
    );
  }
}
