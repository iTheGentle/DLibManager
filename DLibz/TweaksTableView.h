//
//  TweaksTableView.h
//  DLibz
//
//  Created by iTheGentle on 11/11/17.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweaksTableView : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbl;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UILabel *navTitle;
@property (weak,readwrite) NSString *ver;
@property (weak,readwrite) NSString *TName;
@property (weak, nonatomic) IBOutlet UILabel *injectedtweak;
@property (weak,readwrite) NSString *TWeb;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *donelabel;
@property (weak,readwrite) NSString *Bundle;
@property (assign) BOOL installed;
@property (weak, nonatomic) IBOutlet UILabel *disableall;
@property (weak, nonatomic) IBOutlet UISwitch *AllDisabled;
@property (weak,readwrite) NSString *TDescription;
+(void)setBundle:(NSString*)arg1;
@end
