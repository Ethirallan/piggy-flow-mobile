import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/es_widgets/es_blurhash_gallery_card.dart';
import 'package:piggy_flow_mobile/es_widgets/es_gallery_card.dart';
import 'package:piggy_flow_mobile/es_widgets/es_gallery_view.dart';
import 'package:piggy_flow_mobile/models/bill_photo.dart';

class ESPhotoListview extends HookConsumerWidget {
  const ESPhotoListview({
    Key? key,
    required this.photos,
    this.hiddenMsg = false,
  }) : super(key: key);

  final List<BillPhoto> photos;
  final bool hiddenMsg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (photos.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < photos.length; i++)
                  SizedBox(
                    height: 110,
                    width: 110,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl:
                            '${dotenv.env['API_URL']}/bill/getPhoto/${photos[i].path}',
                        imageBuilder: (context, imageProvider) =>
                            GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ESGalleryView(
                                  images: photos,
                                  initialIndex: i,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Hero(
                                tag: photos[i].id ?? 0,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      color: const Color(0xFFFE3F58),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFE3F58),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${i + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        placeholder: (context, url) => ESBlurhashGalleryCard(
                          blurhash: photos[i].blurhash ?? '',
                        ),
                        errorWidget: (context, url, error) {
                          return const ESGalleryCard(
                            child: Icon(
                              Icons.error,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
