//
//  ScrollViewController.h
//  etoile
//
//  Created by mtt on 8/06/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface ScrollViewController : UIViewController {
    
    MainViewController *mavc;

    UIImageView *background;
    UIImageView *titleBar;
    UIScrollView *scrollViewObj;
    UILabel *lblMessage;
    UIButton *btnMain;
    
    UISlider *sliderSpeed;
    int switchViewTo;
    
    //CATransition *animation;
}

@property (nonatomic, retain) MainViewController *mavc;
@property (nonatomic, retain) UIImageView *background;
@property (nonatomic, retain) UIImageView *titleBar;
@property (nonatomic, retain) UIScrollView *scrollViewObj;
@property (nonatomic, retain) UILabel *lblMessage; 
@property (nonatomic, retain) UIButton *btnMain;
@property (nonatomic, retain) UISlider *sliderSpeed;
@property (nonatomic) int switchViewTo;
//@property (nonatomic, retain) CATransition *animation;

- (void)showMain;

- (void)setBackground;
- (void)setSubviewItems;
- (void)setButtons;
- (void)setScrollView;

- (void)switchView;

@end
