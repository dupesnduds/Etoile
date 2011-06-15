//
//  etoileAppDelegate.m
//  etoile
//
//  Created by Cleave Pokotea on 7/06/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//


#import "etoileAppDelegate.h"
#import "MainViewController.h"
//#import "flite.h"

@implementation etoileAppDelegate


@synthesize window;
@synthesize mainViewController;
@synthesize lblMessage;
@synthesize fontSize;


+(etoileAppDelegate *) get 
{
    return (etoileAppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (void)dealloc 
{
    [mainViewController release];
    [window release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:NO];
	
}

/*
int play_message( char* msg_file, char* msg ) 
{
	char* argv[5];
	argv[0] = "flite";
	argv[1] = "-t";
	argv[2] = msg;
	argv[3] = "-o";
	argv[4] = msg_file;
	return flite_main( 5, argv );
}
*/

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration 
{
    // This prevents the view from autorotating to portrait in the simulator
    if ((newStatusBarOrientation == UIInterfaceOrientationPortrait) || (newStatusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) 
    {
        [application setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:NO];
    }
}

@end
