//
//  ViewController.h
//  DLibz
//
//  Created by iTheGentle on 11/11/17.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *applist;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancellabel;
@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UILabel *navTitle;

@property (weak, nonatomic) IBOutlet UITableView *tbl;
-(void)LoadApplications:(NSString*)str;
@end

