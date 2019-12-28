//
//  MainVC.m
//  DLibz
//
//  Created by iTheGentle on 10/24/18.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import "MainVC.h"
#import "WEB.h"
#import "Tweaks.h"
#import <SafariServices/SafariServices.h>
@interface MainVC ()

@end

@implementation MainVC
- (IBAction)BuyGift:(id)sender {
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.paypal.me/ithegentle"]];
    
    SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:URL];
    [self presentViewController:sfvc animated:YES completion:nil];
}
- (IBAction)TellMe:(id)sender {
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://secrets.hex-lab.com"]];
    
    SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:URL];
    [self presentViewController:sfvc animated:YES completion:nil];
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)viewWillAppear:(BOOL)animated{

    for (UIView *subview in self.view.subviews)
    {
        subview.layer.opacity = 0;
        CGRect frame = subview.frame;
        subview.tag = frame.origin.y;
        frame.origin.y = 2300.0;
        subview.frame = frame;
     
    }
    [UIView animateWithDuration:0.4 animations:^(void){
        for (UIView *subview in self.view.subviews)
        {
            subview.layer.opacity = 10;
            CGRect frame = subview.frame;
            frame.origin.y = subview.tag;
            subview.frame = frame;
        }
    }];
}
- (void)viewDidLoad{
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    
    NSString *msg,*title =[[NSString alloc] init];
    msg=@"This is a freeware, you can use it as you can :)\nBut you can support me by sharing it or you can donate via paypal.";
    title=@"announcement!";
    NSDictionary *lang = [[NSDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.apple.springboard.plist"];
    NSString *language = [lang valueForKey:@"XBRecentLocale"];
NSLocale *locale = [NSLocale localeWithLocaleIdentifier:language];
    _contactme.semanticContentAttribute=UISemanticContentAttributeForceLeftToRight;
    if ([[locale languageCode] isEqualToString:@"ar"]){
        [_letsgo setTitle:@"البدء" forState:UIControlStateNormal];
        [_buyheragift setTitle:@"دعم المطور" forState:UIControlStateNormal];
        _buyheragift.titleLabel.font = [UIFont fontWithName:@"Almarai-Bold" size:17.0f];
        _contactme.titleLabel.font = [UIFont fontWithName:@"Almarai-Bold" size:17.0f];
        _letsgo.titleLabel.font = [UIFont fontWithName:@"Almarai-Bold" size:17.0f];
        _smash.titleLabel.font = [UIFont fontWithName:@"Almarai-Bold" size:12.0f];
        _credits.titleLabel.font = [UIFont fontWithName:@"Almarai-Bold" size:17.0f];
        [_credits setTitle:@"قائمة الشكر" forState:UIControlStateNormal];
        [_smash setTitle:@"إعادة تعيين الإعدادات" forState:UIControlStateNormal];
        [_contactme setTitle:@"للتواصل معنا" forState:UIControlStateNormal];
        msg = @"يمكنك الإستفادة من هذا التطبيق بشكل مجاني وبدون أي إعلانات :)\nلكن يمكنك دعم المطور بنشر الأداة أو من خلال القائمة المخصصة لذلك.";
        title = @"تنويه!";
    }

    if(![[usr objectForKey:@"FirstRun"] isEqualToString:@"1"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"♥️"
                                              otherButtonTitles:nil];
        [alert show];
        [usr setObject:@"1" forKey:@"FirstRun"];
    }
}


- (IBAction)ContactMe:(id)sender {

    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
   
    
    UIAlertAction* email = [UIAlertAction
                                actionWithTitle:@"Email"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://v70@hotmail.com"] options:nil completionHandler:nil];
                                }];
    
    UIAlertAction* twitter = [UIAlertAction
                               actionWithTitle:@"Twitter"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=ithegentle"] options:nil completionHandler:nil];
                                   
                               }];
    UIAlertAction* snapchat = [UIAlertAction
                               actionWithTitle:@"Snapchat"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"snapchat://add/ithegentle"] options:nil completionHandler:nil];
                               }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [cancel setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    UIImage *twtr = [self imageWithImage:[UIImage imageNamed:@"twitter"] scaledToSize:CGSizeMake(40,40)];
    UIImage *snp = [self imageWithImage:[UIImage imageNamed:@"snap"] scaledToSize:CGSizeMake(40,40)];
    UIImage *mail = [self imageWithImage:[UIImage imageNamed:@"mail"] scaledToSize:CGSizeMake(40,40)];
    alert.view.tintColor = [UIColor darkGrayColor];
    [twitter setValue:kCAAlignmentLeft forKey: @"titleTextAlignment"];
    [email setValue:kCAAlignmentLeft forKey: @"titleTextAlignment"];
    [snapchat setValue:kCAAlignmentLeft forKey: @"titleTextAlignment"];
    
    [twitter setValue:twtr forKey:@"image"];
    [email setValue:mail forKey:@"image"];
    [snapchat setValue:snp forKey:@"image"];
    [alert addAction:email];
    [alert addAction:twitter];
    [alert addAction:snapchat];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)reset:(id)sender {
    NSArray *files = @[@"/var/mobile/Dlibz/list.plist",@"/private/var/mobile/Library/Preferences/Dlibz.plist",@"/var/mobile/Dlibz/TweaksDB"];
    for (int i =0;i<files.count;i++){
    [[NSFileManager defaultManager] removeItemAtPath:files[i] error:nil];
    }
        NSMutableDictionary *hookDic = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist"];
    [hookDic[@"Filter"] setValue:[NSArray arrayWithObjects:nil] forKey:@"Bundles"];
             [hookDic writeToFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist" atomically:NO];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"Yeeea, we did it 😈"
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    [alert show];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
          NSTask *task = [[NSTask alloc] init];
                     task.launchPath = @"/bin/kill";
                   task.arguments = @[[Tweaks GetApplicationPid:@"DLibz"]];


                 [task launch];
                 [task waitUntilExit];
    });
  

}

@end
