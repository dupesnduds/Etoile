//
//  FlipsideViewController.h
//  etoile
//
//  Created by mtt on 7/06/09.
//  Copyright Make Things Talk 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface MoreViewController : UIViewController <UIWebViewDelegate> {

    MainViewController *mavc;
    IBOutlet UIWebView *webView;

    UIImageView *background;
    UIImageView *titleBar;
    UIButton *btnMain;
    UIButton *btnMtt;
    
    int switchViewTo;
}

@property (nonatomic, retain) MainViewController *mavc;
@property (nonatomic, retain) UIImageView *background;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIImageView *titleBar;
@property (nonatomic, retain) UIButton *btnMain;
@property (nonatomic, retain) UIButton *btnMtt;

@property (nonatomic) int switchViewTo;

- (void)showMain;

- (void)setBackground;
- (void)setSubviewItems;
- (void)setButtons;

- (void)switchView;
- (void)loadAbout;
- (void)loadMtt;
- (void)loadProducts;
- (void)loadNetworkError;


@end

