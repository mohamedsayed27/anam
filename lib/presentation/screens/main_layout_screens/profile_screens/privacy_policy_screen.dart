import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/core/network/dio_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final DioHelper dioHelper = DioHelper();

  Future<ApiResponse> getPrivacy() async {
    try {
      final response = await dioHelper.getData(
        url: "/privacy",
      );

      print(response); // Replace with your endpoint
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataState();
  }

  bool isLoading = false;

  void getDataState() async {
    setState(() {
      isLoading = true;
    });
    apiResponse = await getPrivacy();
    setState(() {
      isLoading = false;
    });
  }

  ApiResponse? apiResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSizedBox(
              height: 20,
            ),
            Text(
              LocaleKeys.privacyPolicy.tr(),
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 20.sp,
                  ),
            ).symmetricPadding(horizontal: 16),
            const CustomSizedBox(
              height: 15,
            ),
            const CustomDivider().symmetricPadding(horizontal: 16),
            const CustomSizedBox(
              height: 20,
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : ListView(
                      children: [
                        Text(
                          initialLocale == "ar"
                              ? apiResponse?.result.content.ar ?? ""
                              : apiResponse?.result.content.en ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 16.sp),
                        ).symmetricPadding(
                          horizontal: 16,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ApiResponse {
  final bool success;
  final int code;
  final String message;
  final Result result;

  ApiResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      result: Result.fromJson(json['result']),
    );
  }
}

class Result {
  final int id;
  final Title title;
  final Content content;
  final String createdAt;
  final String updatedAt;

  Result(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.updatedAt});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      title: Title.fromJson(json['title']),
      content: Content.fromJson(json['content']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Title {
  final String en;
  final String ar;

  Title({required this.en, required this.ar});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      en: json['en'],
      ar: json['ar'],
    );
  }
}

class Content {
  final String en;
  final String ar;

  Content({required this.en, required this.ar});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      en: json['en'],
      ar: json['ar'],
    );
  }
}
