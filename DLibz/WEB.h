//
//  WEB.h
//  DLibz
//
//  Created by iTheGentle on 12/25/18.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WEB : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationBar *BAR;
@property (weak, nonatomic) IBOutlet WKWebView *web;
@property (weak,nonatomic) NSString *weburl;
@end

NS_ASSUME_NONNULL_END
