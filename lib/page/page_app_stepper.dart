import 'package:flutter/material.dart';
import 'package:Inke/widgets/text.dart';
import 'package:Inke/bean/step_bean.dart';

class AppStepperPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AppStepperPage> {

  int _currentStep = 0;

  List<StepBean> steps = [];


  @override
  void initState() {
    super.initState();
    steps.add(StepBean('v1.0.0','App初步搭建完成'));
    steps.add(StepBean('v1.0.1','项目加入Provider状态管理'));
    steps.add(StepBean('v1.0.2','修改一些界面Bug'));
    steps.add(StepBean('v1.0.4','封装一些常用的工具类'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inke'),
        centerTitle: true,
      ),
      body: Stepper(
        currentStep: _currentStep, 
        controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}){
          return Container();
        },
        onStepTapped: (int pos) {
          setState(() {
            _currentStep = pos;
          });
        },
        steps: _buildStepList(),
      ),
    );
  }


  List<Step> _buildStepList(){
    List<Step> list = [];
    for(var bean in steps){
       list.add(_buildStepItem(bean.title, bean.content)); 
    }
    return list;
  }

  Step _buildStepItem(String title,String content){
    return Step(
      title: Text(title,style: TextStyles.blackBold18,),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        child: Text(content,style: TextStyles.greyNormal18,),
      )
    );
  }
}
