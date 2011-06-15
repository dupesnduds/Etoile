//
//  ScrollViewController.m
//  etoile
//
//  Created by mtt on 8/06/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import "ScrollViewController.h"
#import "etoileAppDelegate.h"
#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation ScrollViewController

@synthesize mavc;
@synthesize background;
@synthesize titleBar;
@synthesize scrollViewObj;
@synthesize lblMessage;
@synthesize btnMain;
@synthesize sliderSpeed;
@synthesize switchViewTo;
//@synthesize animation;

- (void)dealloc {
    
    if(mavc) {
        [mavc release];
        mavc=nil;
    }
    
    if(scrollViewObj) {
        [scrollViewObj release];   
        scrollViewObj = nil;
    }
    
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackground];
    [self setSubviewItems];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    return NO;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated; {
    // First rotate the screen:
    [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
    // Then rotate the view and re-align it:
    CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation( degreesToRadian(270) );
    landscapeTransform = CGAffineTransformTranslate(landscapeTransform, -90.0, -70.0 );
    [self.view setTransform:landscapeTransform];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)showMain {
    
    self.switchViewTo = 1;
    [self switchView];
}

- (void)setBackground {
	LOG_CURRENT_METHOD;
    
    // Title bar
	UIImageView *tTitleBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_bar.png"]];
	self.titleBar = tTitleBar;
	[tTitleBar release];
	[self.view addSubview:titleBar];
    [self.view sendSubviewToBack:titleBar];
    
    // Background
	UIImageView *tBkgnd = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bkgnd_plain.png"]];
	self.
    background = tBkgnd;
	[tBkgnd release];
	[self.view addSubview:background];
	[self.view sendSubviewToBack:background];
}

- (void)setSubviewItems {
    LOG_CURRENT_METHOD;
    
    [self setButtons];
    [self setScrollView];
}

- (void)setButtons {
    LOG_CURRENT_METHOD;
    
    // Main
    btnMain = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 3.0f, 68.0f, 44.0f)];
    [btnMain setBackgroundImage:[[UIImage imageNamed:@"button_etoile.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [btnMain setCenter:CGPointMake(44.0f, 25.0f)];    
    [btnMain addTarget:self action:@selector(showMain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMain];
    [btnMain setEnabled:YES];
}

- (void)setScrollView {
    LOG_CURRENT_METHOD;
    
    lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 51, 480, 249)];
    lblMessage.backgroundColor = [UIColor clearColor];
    lblMessage.font = [UIFont systemFontOfSize:148.0];
    lblMessage.textColor = HEXCOLOR(0x241836ff);
    [lblMessage setText:[etoileAppDelegate get].lblMessage];
    LOG(@"TextView (scroll) text:%@", [etoileAppDelegate get].lblMessage);
    [lblMessage sizeToFit];
    
    /*
    CABasicAnimation *scrollText;
    
    scrollText=[CABasicAnimation animationWithKeyPath:@"position.x"];
    scrollText.duration = 3.0;
    scrollText.repeatCount = 10000;
    scrollText.autoreverses = NO;
    scrollText.fromValue = [NSNumber numberWithFloat:500];
    scrollText.toValue = [NSNumber numberWithFloat:-120.0];
    
    [[lblMessage layer] addAnimation:scrollText forKey:@"scrollTextKey"];
     */
    
    scrollViewObj = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 51, 480, 249)];
    scrollViewObj.contentSize = lblMessage.frame.size;

    //[scrollViewObj setContentSize:CGSizeMake(contentWidth, contentHeight)];
    [self.scrollViewObj addSubview:self.lblMessage];
    [self.view addSubview:scrollViewObj];
    
    // ******** Animate!
    
    
    CGRect bounds = scrollViewObj.bounds;
    CGRect labelFrame = lblMessage.frame;
    
    /* Position the label off the edge of the view to start with */
    labelFrame.origin.x += bounds.size.width;
    lblMessage.frame = labelFrame;
    
    /* Set up an animation capture */
    [UIView beginAnimations:@"scrollingAnimation" context:nil]; 
    [UIView setAnimationDuration:20.0];
    [UIView setAnimationRepeatCount:INT_MAX];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    CGRect labelBounds = lblMessage.bounds;
    float width = labelBounds.size.width;
    
    /* Bring the label off the left hand edge of the view */
    labelFrame.origin.x -= (bounds.size.width + width);
    self.lblMessage.frame = labelFrame;
    
    /* Set the animation going */
    [UIView commitAnimations];
    /*
    sliderSpeed = [[UISlider alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 200.0f, 20.0f)];
	sliderSpeed.center = CGPointMake( 280, 25 );
	sliderSpeed.minimumValue = 1.0;
	sliderSpeed.maximumValue = 100.0;
	sliderSpeed.value = 20.0;
	[sliderSpeed addTarget:self action:@selector(xxx) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sliderSpeed];
     */
}

-(void)xxx{
    LOG(@"Speed: %.2f",sliderSpeed.value);
    //[animation setDuration: sliderSpeed.value];
}

- (void)switchView {
    LOG_CURRENT_METHOD;
    
    MainViewController *tmvc = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
    self.mavc = tmvc;
    [tmvc release];
    
    UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
    // remove the current view
    [currentView removeFromSuperview];
    
    // set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.85];
	[animation setType:kCATransitionReveal];
    
    switch(self.switchViewTo) {
        case 1:
            [animation setSubtype:kCATransitionFromTop];
            [theWindow addSubview:[mavc view]];
            break;
    }
    
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	[[theWindow layer] addAnimation:animation forKey:@"swap"];    
}

@end
