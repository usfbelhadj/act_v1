import 'package:actuaryapp/constants.dart';
import 'package:actuaryapp/dashboard/models/course.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../controller.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursesList extends StatefulWidget {
  const CoursesList({Key? key}) : super(key: key);

  @override
  _CoursesListState createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
  late Controller _controller;

  @override
  void initState() {
    _controller = Get.find<Controller>(tag: 'app_controller');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("CoursesList builded");
    return ValueListenableBuilder(
      valueListenable: _controller.coursesListNotifier,
      builder: (BuildContext context, List<Course>? courses, Widget? child) {
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: kDarkBlackColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: courses != null
                ? courses.length == 0
                    ? Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Icon(
                                Icons.library_books,
                                size: 100,
                                color: kBodyTextColor,
                              ),
                            ),
                            Text("You are not enrolled in any courses"),
                            SizedBox(
                              height: defaultPadding,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemExtent: 100.0,
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          return CourseWidget(
                            courses[index].id,
                            courses[index].name,
                            courses[index].imgUrl,
                            courses[index].progress ?? 0,
                          );
                        },
                      )
                : Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ));
      },
    );
  }
}

// ignore: must_be_immutable
class CourseWidget extends StatelessWidget {
  String? title, imgUrl;
  double progress;
  int? id;
  CourseWidget(this.id, this.title, this.imgUrl, this.progress);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading:
            // if (Responsive.isDesktop(context))
            Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(imgUrl!),
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(
          title!,
          textAlign: TextAlign.left,
          style: TextStyle(color: kBodyTextColor, fontWeight: FontWeight.bold),
        ),
        trailing: SizedBox(
          width: 50,
          height: 50,
          child: SfRadialGauge(
            axes: [
              RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.2,
                  cornerStyle: CornerStyle.bothCurve,
                  color: Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: [
                  RangePointer(
                    value: progress,
                    cornerStyle: CornerStyle.bothCurve,
                    width: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
                annotations: [
                  GaugeAnnotation(
                    positionFactor: 0.1,
                    angle: 90,
                    widget: Text(
                      progress.toStringAsFixed(2) + "%",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () async {
        final uri = Uri.parse(
            'https://online-dauphine.com/moodle/course/view.php?id=${id}');

        if (await canLaunchUrl(uri)) {
          await launchUrl(
            uri,
          );
        }
      },
    );
  }
}
