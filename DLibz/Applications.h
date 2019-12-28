//
//  Applications.h
//  DLibz
//
//  Created by iTheGentle on 11/11/17.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Applications : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *navTitle;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UITableView *tbl;
@property (weak, nonatomic) IBOutlet UILabel *managedapps;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *donelabel;
+(void)reload;
@end
