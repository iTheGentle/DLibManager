//
//  WebView.h
//  DLibz
//
//  Created by iTheGentle on 12/1/18.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MyWebView : UIViewController
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (nonatomic,strong) NSString *urlToOpen;
@end

NS_ASSUME_NONNULL_END
