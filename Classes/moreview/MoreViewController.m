//
//  MoreViewController.m
//  etoile
//
//  Created by Cleave Pokotea on 7/06/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//


#import "MoreViewController.h"
#import "etoileAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"


@implementation MoreViewController

@synthesize mavc;
@synthesize background;
@synthesize webView;
@synthesize titleBar;
@synthesize btnMain;
@synthesize btnMtt;
@synthesize switchViewTo;

- (void)dealloc 
{
    if(webView) 
    {
        [webView release];
    }
    
    [super dealloc];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];  
    
    [webView setBackgroundColor:[UIColor clearColor]];
    [webView setOpaque:NO];
    
    [self setBackground];
    [self setSubviewItems];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    return NO;
}

- (void)didReceiveMemoryWarning 
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated
{
    // First rotate the screen:
    [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
    // Then rotate the view and re-align it:
    CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation( degreesToRadian(270) );
    landscapeTransform = CGAffineTransformTranslate(landscapeTransform, -90.0, -70.0 );
    [self.view setTransform:landscapeTransform];
}

- (void)viewDidUnload {}

- (void)showMain 
{
    self.switchViewTo = 1;
    [self switchView];
}

- (void)setBackground 
{
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

- (void)setSubviewItems 
{
    LOG_CURRENT_METHOD;
    
    [self setButtons];
    [self loadAbout];
}

- (void)setButtons 
{
    LOG_CURRENT_METHOD;
    
    // Main
    btnMain = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 68.0f, 44.0f)];
    [btnMain setBackgroundImage:[[UIImage imageNamed:@"button_etoile.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [btnMain setCenter:CGPointMake(44.0f, 24.0f)];    
    [btnMain addTarget:self action:@selector(showMain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMain];
    [btnMain setEnabled:YES];
    
    // MTT
    /*
    btnMtt = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 76.0f, 44.0f)];
    [btnMtt setBackgroundImage:[[UIImage imageNamed:@"mtt.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [btnMtt setCenter:CGPointMake(160.0f, 24.0f)];    
    [btnMtt addTarget:self action:@selector(loadMtt) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMtt];
    [btnMtt setEnabled:YES];
     */
    
    // Etoile
    btnMtt = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    [btnMtt setBackgroundImage:[[UIImage imageNamed:@"fist.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [btnMtt setCenter:CGPointMake(240.0f, 24.0f)];    
    [btnMtt addTarget:self action:@selector(loadAbout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMtt];
    [btnMtt setEnabled:YES];
    
    // MTT
    btnMtt = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 76.0f, 44.0f)];
    [btnMtt setBackgroundImage:[[UIImage imageNamed:@"mtt.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [btnMtt setCenter:CGPointMake(414.0f, 24.0f)];    
    [btnMtt addTarget:self action:@selector(loadMtt) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMtt];
    [btnMtt setEnabled:YES];
}

- (void)switchView 
{
    LOG_CURRENT_METHOD;
    
    MainViewController *tmvc = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
    self.mavc = tmvc;
    [tmvc release];
    
    UIView *currentView = self.view;
	UIView *theWindow = [currentView superview];
    [currentView removeFromSuperview];
    
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.85];
	[animation setType:kCATransitionReveal];
    
    switch(self.switchViewTo) 
    {
        case 1:
            [animation setSubtype:kCATransitionFromTop];
            [theWindow addSubview:[mavc view]];
            break;
    }
    
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	[[theWindow layer] addAnimation:animation forKey:@"swap"];    
}

-(void)loadAbout 
{
    LOG_CURRENT_METHOD;
    
    NSString *helpPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"www"];
    NSURL *helpURL = [NSURL fileURLWithPath:helpPath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:helpURL]];
}

- (void)loadMtt 
{
    LOG_CURRENT_METHOD;
    
    NSString *helpPath = [[NSBundle mainBundle] pathForResource:@"mtt" ofType:@"html" inDirectory:@"www"];
    NSURL *helpURL = [NSURL fileURLWithPath:helpPath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:helpURL]];
}

- (void)loadProducts 
{
    LOG_CURRENT_METHOD;
    
    NSString *helpPath = [[NSBundle mainBundle] pathForResource:@"products" ofType:@"html" inDirectory:@"www"];
    NSURL *helpURL = [NSURL fileURLWithPath:helpPath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:helpURL]];
}

- (void)loadNetworkError 
{
    LOG_CURRENT_METHOD;
    
    NSString *helpPath = [[NSBundle mainBundle] pathForResource:@"network" ofType:@"html" inDirectory:@"www"];
    NSURL *helpURL = [NSURL fileURLWithPath:helpPath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:helpURL]];
}


@end
