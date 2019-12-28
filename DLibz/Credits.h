//
//  Credits.h
//  DLibz
//
//  Created by iTheGentle on 8/7/19.
//  Copyright © 2019 iTheGentle. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Credits : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbl;

+(void)setAccounts:(NSArray*)array;

@end

NS_ASSUME_NONNULL_END
