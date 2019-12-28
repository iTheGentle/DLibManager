//
//  UpdatingDB.h
//  DLibz
//
//  Created by iTheGentle on 5/7/19.
//  Copyright © 2019 iTheGentle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweaks.h"
NS_ASSUME_NONNULL_BEGIN

@interface UpdatingDB : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *label;
-(NSMutableArray*)LoadTweaks;
-(NSMutableDictionary*)LoadApplications;
-(void)finalizing;
-(BOOL)is:(NSString*)TweakInstalled;
-(void)DeleteTweak:(NSString*)Tweak from:(NSString*)db;
-(void)SaveDB;
@end

NS_ASSUME_NONNULL_END
