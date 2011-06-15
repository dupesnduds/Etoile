//
//  etoileAppDelegate.h
//  etoile
//
//  Created by Cleave Pokotea on 7/06/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//


@class MainViewController;


@interface etoileAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    MainViewController *mainViewController;
    
    NSString *lblMessage;
    int fontSize;
    float scrollSpeed;
}


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) NSString *lblMessage;
@property (nonatomic) int fontSize;


+(etoileAppDelegate *) get;


@end

