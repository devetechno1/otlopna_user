import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

import '../../home/widgets/module_view.dart';

class ModuleDialogWidget extends StatelessWidget {
  final Function callback;
  const ModuleDialogWidget({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: PointerInterceptor(child: SingleChildScrollView(child: Container(
        width: 700,
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        color: Theme.of(context).primaryColor.withAlpha(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Text('select_the_type_of_modules_for_your_order'.tr, style: robotoMedium.copyWith(fontSize: 24)),
          ),

          GetBuilder<SplashController>(builder: (splashController) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: splashController.moduleList != null ? ListView.builder(
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 3, childAspectRatio: (1/1),
                //   mainAxisSpacing: Dimensions.paddingSizeLarge, crossAxisSpacing: Dimensions.paddingSizeLarge,
                // ),
                itemCount: splashController.moduleList!.length,
                shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                itemBuilder: (context, index) {
                  return ModuleCard(
                    onTap: () {
                        Get.find<SplashController>().setModule(splashController.moduleList![index]);
                        callback();
                      },
                    image: '${splashController.moduleList![index].iconFullUrl}',
                    name: splashController.moduleList![index].moduleName!,
                    thumpNail: '${splashController.moduleList![index].thumbnailFullUrl}'
                  );
                  // return Padding(
                  //   padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                  //   child: InkWell(
                  //     borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  //     onTap: () {
                  //       Get.find<SplashController>().setModule(splashController.moduleList![index]);
                  //       callback();
                  //     },
                  //     child: Container(
                  //       // padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  //         color: Theme.of(context).cardColor,
                  //         boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 5)],
                  //       ),
                  //       child: SizedBox(
                  //         child: ClipRRect(
                  //           borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  //           child: AspectRatio(
                  //             aspectRatio: 3,
                  //             child: CustomImage(
                  //               image: '${splashController.moduleList![index].thumbnailFullUrl}',
                  //               height: 80,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
              ) : const Center(child: CircularProgressIndicator()),
            );
          }),

        ]),
      ))),
    );
  }
}
