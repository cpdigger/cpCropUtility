cpCropUtility
=============

a reusable component for cropping an image under iOS

1) After building you'll find a "CropUtility.zip" under the Products path. This file you need to unpack to a "CropUtility.framework" folder into your project.
2) Then under the Targets add this as an additional Framework to your project. Section "Build Phases/Link Binary With Libraries"
3) Also under Targets you'll must add the file "Resource.bundle" to the section "Build Phases/Copy Bundle Resources"

How to use this in your code : 

#import <CropUtility/CropUtility.h>

put an NSObject with the IB to your ViewController and set it as CustomClass to "CropUtiltiy" and create an outlet to your code. 

@property (strong, nonatomic) IBOutlet CropUtility *tool;

Once you start the cropping (e.g. press a button) you attach the tool to a UIView (mostly an UIImageView) and after cropping is done you can get the crop Rectangle back. 
That's all ;) 

if(![tool isAttached])
{
    [tool attachToView:self.imageView withRect:CGRectMake(100,100,50,100)];
}
else
{
    CGRect rect = [tool cropRectangle];
    NSLog(@"x=%f ; y=%f; width=%f; height=%f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    [tool detachFromView];
}

comments, suggestions, questions and bug's are welcome !










