#TOValueTransition

**TOValueTransition** is a small and easy to use collection of classes for simple floating value "animations".
Use this library for time based interpolations between two values.

As **TOValueTransition** supports many easing functions, you might want to use it as animation library to easily animate your views.

##Setup

**CocoaPods**   
Simply add `pod 'TOValueTransition', '~> 1.0.1'` to your podfile.  
For more information about CocoaPods and the podfile visit http://guides.cocoapods.org/

**Manual**  
Add all files from /TOValueTransition to your project and target.  


##Usage
In the end there is only one important static method for **TOValueTransition**.  

    /**
     Creates a new instance of TOValueTransition and starts the Transition.
     @param baseValue Value to start from.
     @param targetValue Endvalue.
     @param duration Duration of the transition.
     @param easingId Identifier for the easing. Use one of the Identifier declared in TOEasing.h.
     @param progressHandler Block for progressUpdates.
     @param completedHandler Block for completed.
     @param cancelledHandler Block for cancelled.
     @see TOEasing.h
     @return The transitioning instance.
     */

    TOValueTransition *transition = [TOValueTransition interpolateFrom:0.0 to:1.0 duration:3.4 easing:TOEasingElasticEaseOut progress:^(CGFloat currentValue) {
            
            //Do some update code here. 
            //This block will be called every 1/60 s.
            //e.g. update position of your view.
            
        } completed:^(CGFloat endValue) {
            
            //Finalize your transition here.
            //You might want to nil the transition.
            
        } cancelled:^(CGFloat cancelledValue) {
            
            //This block is called when you cancel the transition.
            //i.e. [transition cancel]
            //Again, you might want to nil the transition.
            
        }];


To cancel a transition you can call `-(BOOL)cancel;` This will stop the progress and will not call the completed block.

If you take a look at the Sample project (it's an ios application) you can see how to use TOValueTransition to animate a white dot on the screen.

##Contact
For any questions or information feel free to contact me  [@toastedtoast](http://www.twitter.com/toastedtoast)
