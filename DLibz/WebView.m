//
//  WebView.m
//  DLibz
//
//  Created by iTheGentle on 12/1/18.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import "WebView.h"
#import <WebKit/WebKit.h>
@interface MyWebView ()<WKNavigationDelegate,WKUIDelegate>
@end

@implementation MyWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"//////");
    NSURL *targetURL = [NSURL URLWithString:@"http://google.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    _webView.navigationDelegate = self;
    _webView.UIDelegate=self;
    
    [_webView loadRequest:request];
    
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
