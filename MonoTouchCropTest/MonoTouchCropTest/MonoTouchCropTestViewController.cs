using System;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

using MonoCropUtility;

namespace MonoTouchCropTest
{


	public partial class MonoTouchCropTestViewController : UIViewController
	{
		private CropUtility cropper; 

		public MonoTouchCropTestViewController() : base ("MonoTouchCropTestViewController", null)
		{
		}
		
		public override void DidReceiveMemoryWarning()
		{
			// Releases the view if it doesn't have a superview.
			base.DidReceiveMemoryWarning();
			
			// Release any cached data, images, etc that aren't in use.
		}
		
		public override void ViewDidLoad()
		{
			base.ViewDidLoad();

			this.cropper = new CropUtility();
			
			// Perform any additional setup after loading the view, typically from a nib.
		}
		
		public override void ViewDidUnload()
		{
			base.ViewDidUnload();
			
			// Clear any references to subviews of the main view in order to
			// allow the Garbage Collector to collect them sooner.
			//
			// e.g. myOutlet.Dispose (); myOutlet = null;
			
			ReleaseDesignerOutlets();
		}
		
		public override bool ShouldAutorotateToInterfaceOrientation(UIInterfaceOrientation toInterfaceOrientation)
		{
			// Return true for supported orientations
			return (toInterfaceOrientation != UIInterfaceOrientation.PortraitUpsideDown);
		}

		partial void doCrop(NSObject sender)
		{
			if(this.cropper.IsAttached)
				this.cropper.detachFromView();
			else
				this.cropper.attachToView(this.imageView, new RectangleF(100,100,100,50));

		} 
	}
}

