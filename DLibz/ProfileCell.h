//
//  ProfileCell.h
//  DLibz
//
//  Created by iTheGentle on 8/7/19.
//  Copyright © 2019 iTheGentle. All rights reserved.
//

#import "CellTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileCell : CellTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Icon;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *twitter;

@end

NS_ASSUME_NONNULL_END
