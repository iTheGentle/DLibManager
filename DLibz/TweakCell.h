//
//  TweakCell.h
//  DLibz
//
//  Created by iTheGentle on 11/11/17.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweakCell : UITableViewCell
+(void)addApplicationWithName:(NSString*)name andBundle:(NSString*)bundle DisabledTweaks:(NSArray*)tweak;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *file;
@property (weak, nonatomic) IBOutlet UISwitch *status;
@property (weak, nonatomic) NSString *bndle;
@property (weak, nonatomic) IBOutlet UILabel *warning;
@property (weak, nonatomic) UIViewController *vc;
@end
