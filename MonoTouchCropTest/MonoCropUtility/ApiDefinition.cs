using System;
using System.Drawing;

using MonoTouch.ObjCRuntime;
using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace MonoCropUtility
{
	[BaseType (typeof (NSObject))]
	public interface CropUtility {
		[Export ("attachToView:withRect:")]
		void attachToView(UIView view, RectangleF rectangle);

		[Export("detachFromView")]
		void detachFromView();

		[Export ("cropRectangle")]
		RectangleF CropRectangle { get; }

		[Export ("isAttached")]
		bool IsAttached { get; }
	}
}