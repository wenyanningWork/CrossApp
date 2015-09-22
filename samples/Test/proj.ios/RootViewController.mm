#import "RootViewController.h"
#import "EAGLView.h"
#import "CrossApp.h"
#import <UIKit/UIKit.h>
@implementation RootViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    //CGFloat scale = [[UIScreen mainScreen] scale];
    
    //rect.size = [[UIScreen mainScreen]applicationFrame].size;

    EAGLView *__glView = [EAGLView viewWithFrame: rect
                                     pixelFormat: kEAGLColorFormatRGB565
                                     depthFormat: GL_DEPTH24_STENCIL8_OES
                              preserveBackbuffer: NO
                                      sharegroup: nil
                                   multiSampling: NO
                                 numberOfSamples: 0];
    [__glView setMultipleTouchEnabled:YES];
    [self.view addSubview:__glView];
    
    NSFileManager* fm=[NSFileManager defaultManager];
    NSString* path = [NSString stringWithUTF8String:"/System/Library/Fonts"];
    NSArray *files = [fm subpathsAtPath: path];
    
    for (int i = 0; i < files.count; i++)
    {
        NSLog(@"font : %@", files[i]);
        NSString* s = files[i];
        std::string ss = std::string("/System/Library/Fonts/") + [s UTF8String];
        unsigned long pSize = 0;
        
        FILE* fp = fopen(ss.c_str(), "rb");
        if (fp)
        {
            fseek(fp, 0L, SEEK_END);
            pSize = ftell(fp);
            fseek(fp,0,SEEK_SET);
            fclose(fp);
        }
        
        NSLog(@"fontSize : %lu", pSize / 1048576);
    }
}


// Override to allow orientations other than the default portrait orientation.
// This method is deprecated on ios6
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait( interfaceOrientation );
}

// For ios6, use supportedInterfaceOrientations & shouldAutorotate instead
- (NSUInteger) supportedInterfaceOrientations{
#ifdef __IPHONE_6_0
    return UIInterfaceOrientationMaskPortrait;
#endif
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL) shouldAutorotate
{
    return NO;
}

//fix not hide status on ios7
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}


@end
