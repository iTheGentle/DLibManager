//
//  PackageInfoViewController.m
//  DLibz
//
//  Created by iTheGentle on 4/23/19.
//  Copyright © 2019 iTheGentle. All rights reserved.
//

#import "PackageInfoViewController.h"
#import "Tweaks.h"
@interface PackageInfoViewController ()<WKNavigationDelegate>

@end
UILabel *lbl;
@implementation PackageInfoViewController

- (void)viewDidLoad {

        NSDictionary *lang = [[NSDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.apple.springboard.plist"];
        NSString *language = [lang valueForKey:@"XBRecentLocale"];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:language];

        if ([[locale languageCode] isEqualToString:@"ar"]){
            _tweakinfo.text = @"معلومات الأداة";
            _tweaktitle.text = @"اسم الأداة:";
            _tweakdes.text = @"وصف الأداة:";
            _manage.text = @"إدارة:";
            [_uninstalllabel setTitle:@"إزالة الأداة" forState:UIControlStateNormal];
            _warning.text = @"⚠️ تنبيه ⚠️\nكن حذراً عند إستخدام هذا الخيار، سيقوم بحذف الأداة!";
        }
    lbl=[[UILabel alloc] init];
    lbl.text=_TweakBundle;
    [super viewDidLoad];
    _tName.text = _TweakName;
    _tVer.text = _TweakVer;

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_TweakPage]];
    //[_tPage loadRequest:request];
  //  _tPage.navigationDelegate=self;
//    _tPage.userInteractionEnabled=0;
    _tDesc.text = [_TweakDescription stringByReplacingOccurrencesOfString:@"Description: " withString:@""];
    [_tDesc sizeToFit];
    [_tDesc setNeedsDisplay];
if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
    _navBar.frame = CGRectMake(0, [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom, self.view.frame.size.width, _navBar.frame.size.height);
    }
    else {
        _navBar.frame = CGRectMake(0, 0, self.view.frame.size.width, _navBar.frame.size.height);
    }
    // _tbl.frame =CGRectMake(0, _navBar.frame.size.height , self.view.frame.size.width, self.view.frame.size.height - 44);
    _navTitle.frame =CGRectMake(_navTitle.frame.origin.x,_navBar.frame.origin.y + 10,_navTitle.frame.size.width,_navTitle.frame.size.height);
    _scroll.frame = CGRectMake(0, _navBar.frame.size.height + _navBar.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - _navBar.frame.size.height);
    [_scroll setContentSize:CGSizeMake(self.view.frame.size.width, 700)];
}


- (UILabel *)getLabelWithMessage:(NSMutableString *)message withTitle:(NSString *)title {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentLeft];
    paragraphStyle.paragraphSpacing = 2.0f;
    paragraphStyle.headIndent = 20.0;
    paragraphStyle.firstLineHeadIndent = 20.0;
    paragraphStyle.tailIndent = -20.0;
    
    NSMutableAttributedString *attribString = [[NSMutableAttributedString alloc]initWithString:message];
    [attribString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [message length])];
    [attribString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:NSMakeRange(0, [message length])];
    [attribString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12.f] range:NSMakeRange(0, [title length])];
    
    UILabel *label = [[UILabel alloc] init];
    [label setAttributedText:attribString];
    [label setNumberOfLines:0];
    [label sizeToFit];
    return label;
}
- (IBAction)Uninstall:(id)sender {
    UIButton *btn = sender;
    btn.enabled=0;
    [Tweaks UninstallTweakWithBundle:lbl.text withSender:btn];
}
- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
