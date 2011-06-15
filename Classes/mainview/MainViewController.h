//
//  MainViewController.h
//  etoile
//
//  Created by Cleave Pokotea on 7/06/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//


#import <UIKit/UIKit.h>


@class MoreViewController;
@class ScrollViewController;

@interface MainViewController : UIViewController <UITextViewDelegate> 
{
    MoreViewController *movc;
    ScrollViewController *svc;
    
    UIImageView *background;
    UIImageView *titleBar;
    //UIImageView *aaa;
    UIButton *etoile;
    UIButton *aaa;
    UITextView *content;
    UIButton *btnPlus;
    UIButton *btnMinus;
    UIButton *btnKeyboardOpen;
    UIButton *btnKeyboardClose;
    UIButton *btnScroll;
    UIButton *btnInfo;
    
    int switchViewTo;
    int fontSize;
    BOOL showKeyboard;
}


@property (nonatomic, retain) MoreViewController *movc;
@property (nonatomic, retain) ScrollViewController *svc;
@property (nonatomic, retain) UIImageView *background;
@property (nonatomic, retain) UIImageView *titleBar;
//@property (nonatomic, retain) UIImageView *aaa;
@property (nonatomic, retain) UIButton *etoile;
@property (nonatomic, retain) UIButton *aaa;
@property (nonatomic, retain) UITextView *content;
@property (nonatomic, retain) UIButton *btnPlus;
@property (nonatomic, retain) UIButton *btnMinus;
@property (nonatomic, retain) UIButton *btnKeyboardOpen;
@property (nonatomic, retain) UIButton *btnKeyboardClose;
@property (nonatomic, retain) UIButton *btnScroll;
@property (nonatomic, retain) UIButton *btnInfo;
@property (nonatomic) int switchViewTo;


- (void)showInfo;
- (void)showScroll;
- (void)toggleKeyboard;
- (void)fontPlus;
- (void)fontMinus;
- (void)setBackground;
- (void)setSubviewItems;
- (void)setTextView;
- (void)setButtons;
- (void)switchView;


@end
