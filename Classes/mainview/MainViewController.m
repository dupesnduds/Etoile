//
//  MainViewController.m
//  etoile
//
//  Created by mtt on 7/06/09.
//  Copyright Make Things Talk 2009. All rights reserved.
//

#import "MainViewController.h"
#import "etoileAppDelegate.h"
#import "ScrollViewController.h"
#import "MoreViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation MainViewController

@synthesize movc;
@synthesize svc;
@synthesize background;
@synthesize titleBar;
@synthesize etoile;
@synthesize aaa;
@synthesize content;
@synthesize btnPlus, btnMinus;
@synthesize btnKeyboardOpen, btnKeyboardClose;
@synthesize btnScroll;
@synthesize btnInfo;
@synthesize switchViewTo;

- (void)dealloc {
    /*
    if(movc) {
        [movc release];
    }
     */
    
    [super dealloc];
}

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
     
    if([etoileAppDelegate get].fontSize != 0) {
        fontSize = [etoileAppDelegate get].fontSize;
    } else {
        fontSize = 30;
    }
     showKeyboard = NO;
     
    [self setBackground];
    [self setSubviewItems];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
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

- (void)showInfo {    
	
	self.switchViewTo = 1;
    [self switchView];
}

- (void)showScroll {
    
    self.switchViewTo = 2;
    [self switchView];
}

- (void)toggleKeyboard {
    LOG_CURRENT_METHOD;
    
    if(showKeyboard) {
        [content becomeFirstResponder];
    } else {
        
        [content resignFirstResponder];
    }
}


- (void)fontPlus {
    LOG_CURRENT_METHOD;
    
    if(fontSize > 10 && !btnMinus.enabled) {
        [btnMinus setEnabled:YES];            
    }
    
    if(fontSize < 149) {
        if(!btnPlus.enabled) {
            [btnPlus setEnabled:YES];            
        }
        
        if(!btnPlus.enabled) {
            [btnPlus setEnabled:YES];            
        }
        
        fontSize = fontSize++;
        fontSize = fontSize + 10;
        content.font = [UIFont systemFontOfSize:fontSize];
        [etoileAppDelegate get].fontSize = fontSize;
    } else {
        [btnPlus setEnabled:NO];
    }
}

- (void)fontMinus {
    LOG_CURRENT_METHOD;
    
    if(fontSize < 149 && !btnPlus.enabled) {
        [btnPlus setEnabled:YES];            
    }
    
    if(fontSize > 10) {
        if(!btnMinus.enabled) {
            [btnMinus setEnabled:YES];            
        }
        
        fontSize = fontSize--;
        fontSize = fontSize - 10;
        content.font = [UIFont systemFontOfSize:fontSize];
        [etoileAppDelegate get].fontSize = fontSize;
    } else {
        [btnMinus setEnabled:NO];
    }
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
	self.background = tBkgnd;
	[tBkgnd release];
	[self.view addSubview:background];
	[self.view sendSubviewToBack:background];
    
    // Aaa
    /*
	UIImageView *taaa = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aaa.png"]];
	self.aaa = taaa;
	[taaa release];
    [aaa setCenter:CGPointMake(426.0f, 27.0f)]; 
	[self.view addSubview:aaa];
     */
}

- (void)setSubviewItems {
    LOG_CURRENT_METHOD;
    
    [self setTextView];
    [self setButtons];
    
    
}

- (void)setTextView {
    LOG_CURRENT_METHOD;
    
    content = [[UITextView alloc] initWithFrame:CGRectMake(0, 51, 480, 249)];
    content.delegate = self;
    content.font = [UIFont systemFontOfSize:14];
    //content.font = [UIFont systemFontOfSize:fontSize];
    content.textColor = HEXCOLOR(0x241836ff);
    content.scrollEnabled = YES;
    content.backgroundColor = [UIColor clearColor];
    [content becomeFirstResponder];
    [self.view addSubview:content];   
    
    LOG(@"Content text:%@", [etoileAppDelegate get].lblMessage);
    if([[etoileAppDelegate get].lblMessage length] != 0) {
        content.text = [etoileAppDelegate get].lblMessage;
    }
}

- (void)setButtons {
    LOG_CURRENT_METHOD;
    
    // Scroll
    btnScroll = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 68.0f, 44.0f)];
    [btnScroll setBackgroundImage:[[UIImage imageNamed:@"button_scroll.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [btnScroll setCenter:CGPointMake(42.0f, 24.0f)]; 
    [btnScroll addTarget:self action:@selector(showScroll) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnScroll];
    [btnScroll setEnabled:NO];
    
    // Keyboard open
    btnKeyboardOpen = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 64.0f, 44.0f)];
    [btnKeyboardOpen setBackgroundImage:[[UIImage imageNamed:@"keyboard_open.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [btnKeyboardOpen setCenter:CGPointMake(140.0f, 24.0f)];    
    [btnKeyboardOpen addTarget:self action:@selector(toggleKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnKeyboardOpen];
    [self.view sendSubviewToBack:btnKeyboardOpen];
    [btnKeyboardOpen setEnabled:YES];
    
    // Keyboard close
    btnKeyboardClose = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 64.0f, 44.0f)];
    [btnKeyboardClose setBackgroundImage:[[UIImage imageNamed:@"keyboard_close.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [btnKeyboardClose setCenter:CGPointMake(140.0f, 24.0f)];    
    [btnKeyboardClose addTarget:self action:@selector(toggleKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnKeyboardClose];
    //[self.view sendSubviewToBack:btnKeyboardClose];
    [btnKeyboardClose setEnabled:YES];
    
    // Etoile
    etoile = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 68.0f, 44.0f)];
    [etoile setBackgroundImage:[[UIImage imageNamed:@"etoile.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [etoile setBackgroundImage:[[UIImage imageNamed:@"etoile.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateSelected];
    [etoile setBackgroundImage:[[UIImage imageNamed:@"etoile.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    [etoile setCenter:CGPointMake(240.0f, 24.0f)];    
    [self.view addSubview:etoile];
    [etoile setEnabled:NO];
    
    // Info
    btnInfo = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    [btnInfo setBackgroundImage:[[UIImage imageNamed:@"button_more.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [btnInfo setCenter:CGPointMake(336.0f, 25.0f)];   
    [btnInfo addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnInfo];
    [btnInfo setEnabled:NO];
    
    // Minus
    btnMinus = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    [btnMinus setBackgroundImage:[[UIImage imageNamed:@"button_minus.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [btnMinus setCenter:CGPointMake(396.0f, 24.0f)];    
    [btnMinus addTarget:self action:@selector(fontMinus) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMinus];
    [btnMinus setEnabled:NO];
    
    // Aaa
    aaa = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    [aaa setBackgroundImage:[[UIImage imageNamed:@"aaa.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [aaa setBackgroundImage:[[UIImage imageNamed:@"aaa.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateSelected];
    [aaa setBackgroundImage:[[UIImage imageNamed:@"aaa.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    [aaa setCenter:CGPointMake(426.0f, 24.0f)];    
    [self.view addSubview:aaa];
    [aaa setEnabled:NO];
    
    // Plus
    btnPlus = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    [btnPlus setBackgroundImage:[[UIImage imageNamed:@"button_plus.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [btnPlus setCenter:CGPointMake(457.0f, 24.0f)];    
    [btnPlus addTarget:self action:@selector(fontPlus) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPlus];
    [btnPlus setEnabled:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)thetextField {
    [content resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	//if([text isEqualToString:@"\n"])
	if([text isEqualToString:@"^"]) {
        
		[textView resignFirstResponder];
		return NO;
	}
	return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    LOG_CURRENT_METHOD;
    
    [textView scrollRangeToVisible:NSMakeRange([textView.text length], 0)];
    
    // remove the height of the keyboard from the text view
	CGRect frame = CGRectMake(0, 51, 480, 269);
	//remove the height of the keyboard
	frame.size.height = 117; 
	content.frame = frame;
    
    // shrink font for editing
    textView.font = [UIFont systemFontOfSize:14];
    
    // keyboard appeared
    showKeyboard = NO;
    [self.view sendSubviewToBack:btnKeyboardOpen];
    [self.view bringSubviewToFront:btnKeyboardClose];
    [etoile setEnabled:NO];
    [aaa setEnabled:NO];
    [btnInfo setEnabled:NO];
    [btnScroll setEnabled:NO];
    [btnMinus setEnabled:NO];
    [btnPlus setEnabled:NO];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    LOG_CURRENT_METHOD;
    
    [etoileAppDelegate get].lblMessage = textView.text;
    LOG(@"TextView (main) text:%@", textView.text);

    CGRect frame = CGRectMake(0, 51, 480, 269);
	frame.size.height = 280; //what ever height you need. With a nav bar + bottom bar its 372
	content.frame = frame;
    
    // return font to default size
    textView.font = [UIFont systemFontOfSize:fontSize];
    
    // keyboard disappeared
    showKeyboard = YES;
    [self.view sendSubviewToBack:btnKeyboardClose];
    [self.view bringSubviewToFront:btnKeyboardOpen];
    [etoile setEnabled:YES];
    [aaa setEnabled:YES];
    [btnInfo setEnabled:YES];
    
    if(textView.hasText) {
        [btnScroll setEnabled:YES];
    }else {
        [btnScroll setEnabled:NO];
    }
    
    [btnMinus setEnabled:YES];
    [btnPlus setEnabled:YES];
}

- (void)switchView {
    LOG_CURRENT_METHOD;
    
    MoreViewController *tmvc = [[MoreViewController alloc] initWithNibName:@"MoreView" bundle:nil];
    self.movc = tmvc;
    [tmvc release];
    
    ScrollViewController *tsvc = [[ScrollViewController alloc] initWithNibName:@"ScrollView" bundle:nil];
    self.svc = tsvc;
    [tsvc release];
    
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
            [theWindow addSubview:[movc view]];
            [animation setSubtype:kCATransitionFromBottom];
            break;
        case 2:
            [theWindow addSubview:[svc view]];
            [animation setSubtype:kCATransitionFromBottom];
            break;
    }
    
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	[[theWindow layer] addAnimation:animation forKey:@"swap"];    
}


@end
