//
//  PackageInfoViewController.h
//  DLibz
//
//  Created by iTheGentle on 4/23/19.
//  Copyright © 2019 iTheGentle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PackageInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *navTitle;
@property (weak, nonatomic) IBOutlet UILabel *tweakinfo;
@property (weak, nonatomic) NSString *TweakName;
@property (weak, nonatomic) IBOutlet UILabel *tweaktitle;
@property (weak, nonatomic) NSString *TweakBundle;
@property (weak, nonatomic) NSString *TweakVer;
@property (weak, nonatomic) IBOutlet UILabel *tweakdes;
@property (weak, nonatomic) NSString *TweakPage;
@property (weak, nonatomic) NSString *TweakDescription;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UILabel *tVer;
@property (weak, nonatomic) IBOutlet UILabel *tName;
@property (weak, nonatomic) IBOutlet UILabel *tDesc;
@property (weak, nonatomic) IBOutlet UILabel *manage;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIButton *uninstalllabel;
@property (weak, nonatomic) IBOutlet UILabel *warning;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet WKWebView *tPage;

@end

NS_ASSUME_NONNULL_END
