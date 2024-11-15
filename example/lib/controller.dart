import 'package:quick_change/quick_change.dart';

class  CounterController extends QuickChangeController<int> {



   //static final QuickChangeController<int> counterController = QuickChangeController<int>();
   incrementCounter(int cVal) {
     print(cVal);
int val = cVal+1;

     setData(val);



   }
   decrementCounter(int cVal) {
     int val = cVal-1;


     setData(val);



   }





}