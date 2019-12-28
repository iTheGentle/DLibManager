//
//  WEB.m
//  DLibz
//
//  Created by iTheGentle on 12/25/18.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import "WEB.h"
#import <SafariServices/SafariServices.h>
@interface WEB ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation WEB
- (IBAction)f:(id)sender {
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://secrets.hex-lab.com"]];
    
    SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:URL];
    [self presentViewController:sfvc animated:YES completion:nil];
}
- (IBAction)Done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)prefersStatusBarHidden{
    return 1;
}
- (void)viewDidLoad {
    [super viewDidLoad];


    if((int)[[UIScreen mainScreen] nativeBounds].size.height >= 2436){
        _BAR.frame = CGRectMake(0, 40, self.view.frame.size.width, 44);
        _web.frame =CGRectMake(0, 80 , self.view.frame.size.width, self.view.frame.size.height - 80);
    }
    else {
        _BAR.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
        _web.frame =CGRectMake(0, 40 , self.view.frame.size.width, self.view.frame.size.height - 44);
    }
    NSURL *targetURL = [NSURL URLWithString:_weburl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    _web.navigationDelegate = self;
    _web.UIDelegate=self;
    
    [_web loadRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
