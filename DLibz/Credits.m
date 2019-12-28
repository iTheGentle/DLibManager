//
//  Credits.m
//  DLibz
//
//  Created by iTheGentle on 8/7/19.
//  Copyright © 2019 iTheGentle. All rights reserved.
//

#import "Credits.h"
#import "ProfileCell.h"

@interface Credits ()

@end

@implementation Credits
NSMutableArray *names,*twitter;
- (void)viewDidLoad {
    [super viewDidLoad];
    names = [[NSMutableArray alloc] initWithObjects:@"Abdulhameed Dawai",@"Abdullah AlIbrahim",@"CoolStar",@"Dr.Nouf",@"Faleh AlRashidi",@"Hussain AlMukhles",@"Mohammed AlDubaikhi",@"Nawaf AlMutairi",@"Rayan Petrich",@"Saleh AlAmri",@"Saurik",@"Sultan Albarqi",@"Thamer AlGhali",@"Turki AlHarbi",@"Guilherme Rambo",@"khaled AlBuqami", nil];
    twitter = [[NSMutableArray alloc] initWithObjects:@"idawai1",@"abdullahalbrhim",@"coolstarorg",@"ithepros",@"al3bsi",@"iHUSSEN0",@"M_aldubaikhi",@"Nawaf_NM",@"rpetrich",@"salehalamri97",@"saurik",@"ss_store1",@"mr_thamer",@"a1harbi_ksa",@"_inside",@"Cydia20", nil];
    _tbl.dataSource=self;
    _tbl.delegate=self;
    _tbl.separatorStyle=UITableViewCellSeparatorStyleNone;
    pics = [[NSMutableArray alloc] init];
}

NSArray *accounts;
NSMutableArray *pics;

+(void)setAccounts:(NSArray *)array{
    accounts = [[NSArray alloc] init];
    accounts = array;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil] forCellReuseIdentifier:@"ProfileCell"];
    ProfileCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSData * data =[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:accounts[indexPath.row]]];
        
            
        dispatch_async(dispatch_get_main_queue(), ^(void){
            cell.Icon.image = [UIImage imageWithData: data];
            
        });
                
   
    });

    cell.twitter.text=twitter[indexPath.row];
    cell.Title.text = names[indexPath.row];
    tableView.backgroundColor = self.view.backgroundColor;
    cell.backgroundColor = self.view.backgroundColor;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return accounts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
