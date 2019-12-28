//
//  ProfileCell.m
//  DLibz
//
//  Created by iTheGentle on 8/7/19.
//  Copyright © 2019 iTheGentle. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)go:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@",self.twitter.text]] options:nil completionHandler:nil];
}

@end
