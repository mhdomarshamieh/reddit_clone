import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/error_text.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/core/utils.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';
import 'package:reddit_clone/models/community_model.dart';
import 'package:reddit_clone/theme/pallete.dart';
import 'package:dotted_border/dotted_border.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen({super.key, required this.name});

  @override
  ConsumerState createState() => _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;

  void selectBannerImage() async {
    final res = await picKImage();

    if (res != null) {
      bannerFile = File(res.files.first.path!);
      setState(() {});
    }
  }

  void selectProfileImage() async {
    final res = await picKImage();

    if (res != null) {
      profileFile = File(res.files.first.path!);
      setState(() {});
    }
  }

  void save(Community community) {
    ref.read(communityControllerProvider.notifier).editCommunity(
        community: community,
        bannerFile: bannerFile,
        profileFile: profileFile,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) => Scaffold(
            backgroundColor: Pallete.darkModeAppTheme.colorScheme.background,
            appBar: AppBar(
              title: const Text('Edit Community'),
              actions: [
                TextButton(
                  onPressed: () => save(community),
                  child: const Text('Save'),
                ),
              ],
            ),
            body: isLoading
                ? const Loader()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: selectBannerImage,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  strokeCap: StrokeCap.round,
                                  color: Pallete.darkModeAppTheme.textTheme
                                      .bodyMedium!.color!,
                                  dashPattern: const [10, 4],
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 150,
                                    child: bannerFile != null
                                        ? Image.file(bannerFile!)
                                        : community.banner.isEmpty ||
                                                community.banner ==
                                                    Constants.bannerDefault
                                            ? const Center(
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 40,
                                                ),
                                              )
                                            : Image.network(community.banner),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                bottom: 20,
                                child: GestureDetector(
                                  onTap: selectProfileImage,
                                  child: profileFile != null
                                      ? CircleAvatar(
                                          backgroundImage:
                                              FileImage(profileFile!),
                                          radius: 32,
                                        )
                                      : CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(community.avatar),
                                          radius: 32,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
