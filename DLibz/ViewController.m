//
//  ViewController.m
//  DLibz
//
//  Created by iTheGentle on 11/11/17.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import "ViewController.h"
#import "Tweaks.h"

#import "AppList/AppList.h"
#import "CellTableViewCell.h"
#import "TweaksTableView.h"

@interface ViewController ()

@end
NSMutableArray *arr,*arr2,*title;

@implementation ViewController
- (IBAction)DLibz:(id)sender {
//    [Tweaks updatePlist];
//    [Tweaks OpenApp:@""];


    
}
ALApplicationList *al;
-(void)LoadApplications:(NSString *)str{
    if([str isEqualToString:@""]){
        al = [NSClassFromString(@"ALApplicationList") sharedApplicationList];
        NSMutableDictionary *dic= [al applicationsFilteredUsingPredicate:[NSPredicate predicateWithFormat:@"isSystemApplication = NO"]
                                   
                                                             onlyVisible:YES titleSortedIdentifiers:nil];
        NSMutableDictionary *dic2 =[[NSMutableDictionary alloc] initWithDictionary:[al applicationsFilteredUsingPredicate:[NSPredicate predicateWithFormat:@"isSystemApplication = YES"]
                                                                                    
                                                                                                              onlyVisible:YES titleSortedIdentifiers:nil]];
        [dic2 addEntriesFromDictionary:dic];
        [dic2 removeObjectForKey:@"com.iTheGentle.Dlibz"];
        arr = [[NSMutableArray alloc] init];
        arr2 = [[NSMutableArray alloc] init];
        [arr2 addObjectsFromArray:[dic2 allValues]];
        //[arr2 addObjectsFromArray:[dic2 allValues]];
        arr2 = [arr2 sortedArrayUsingSelector:
                @selector(localizedCaseInsensitiveCompare:)];
        for (int i=0; i<dic2.count; i++) {
            [arr addObject:[dic2 allKeysForObject:arr2[i]].firstObject];
        }
    }
    else {
        al = [NSClassFromString(@"ALApplicationList") sharedApplicationList];
        NSMutableDictionary *dic= [al applicationsFilteredUsingPredicate:[NSPredicate predicateWithFormat:@"isSystemApplication = NO"]
                                   
                                                             onlyVisible:YES titleSortedIdentifiers:nil];
        NSMutableDictionary *dic2 =[[NSMutableDictionary alloc] initWithDictionary:[al applicationsFilteredUsingPredicate:[NSPredicate predicateWithFormat:@"isSystemApplication = YES"]
                                                                                    
                                                                                                              onlyVisible:YES titleSortedIdentifiers:nil]];
        [dic2 addEntriesFromDictionary:dic];
        [dic2 removeObjectForKey:@"com.iTheGentle.Dlibz"];
        arr = [[NSMutableArray alloc] init];
        title = [[NSMutableArray alloc] init];
        arr2 = [[NSMutableArray alloc] init];
        [arr2 addObjectsFromArray:[dic2 allValues]];
        //[arr2 addObjectsFromArray:[dic2 allValues]];
        arr2 = [arr2 sortedArrayUsingSelector:
                @selector(localizedCaseInsensitiveCompare:)];
        for (int i=0; i<dic2.count; i++) {
            
            NSData *decode = [[NSString stringWithFormat:@"%@",arr2[i]] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *temp = [[[NSString alloc] initWithData:decode encoding:NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"?" withString:@""];
            
            
            if([[temp lowercaseString] hasPrefix:[str lowercaseString]]){
            [arr addObject:[dic2 allKeysForObject:arr2[i]].firstObject];
            [title addObject:arr2[i]];
                
            }
        
        }
        
        
      }
  
}
CGFloat ty;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoadApplications:@""];
    _search.delegate =self;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
        _navBar.frame = CGRectMake(0, [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom, self.view.frame.size.width, _navBar.frame.size.height);
        
        _tbl.frame =CGRectMake(0, _navBar.frame.size.height + _navBar.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height - [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom -(_navBar.frame.size.height + _navBar.frame.origin.y)  );
    }
    else {
        _navBar.frame = CGRectMake(0, 0, self.view.frame.size.width, _navBar.frame.size.height);
        
        _tbl.frame =CGRectMake(0, _navBar.frame.size.height + _navBar.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height - _navBar.frame.size.height);
    }
    _navTitle.frame =CGRectMake(_navTitle.frame.origin.x,_navBar.frame.origin.y + 10,_navTitle.frame.size.width,_navTitle.frame.size.height);
    
   
    
    _tbl.dataSource=self;
    _tbl.delegate=self;
    ty = self.tbl.frame.origin.y;

        NSDictionary *lang = [[NSDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.apple.springboard.plist"];
        NSString *language = [lang valueForKey:@"XBRecentLocale"];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:language];

        if ([[locale languageCode] isEqualToString:@"ar"]){
            [_cancellabel setTitle: @"إلغاء"];
            _applist.text = @"قائمة التطبيقات";
        }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return arr.count;
}
- (IBAction)Cancel:(id)sender {
    [self dismissViewControllerAnimated:1 completion:nil];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerNib:[UINib nibWithNibName:@"CellTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    CellTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIImage *largeIcon = [al iconOfSize:ALApplicationIconSizeLarge forDisplayIdentifier:arr[indexPath.row]];
    cell.icon.image  =largeIcon;
   if(![self->_search.text isEqualToString:@""]){
    cell.Display.text= title[indexPath.row];
   }
   else {
    cell.Display.text= arr2[indexPath.row];
   }
    
    cell.contentView.backgroundColor = self.view.backgroundColor;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *app = [[NSString alloc] init];
    if(![self->_search.text isEqualToString:@""]){
     app= title[indexPath.row];
    }
    else {
     app= arr2[indexPath.row];
    }
    [TweaksTableView setBundle:arr[indexPath.row]];
    [Tweaks updatePlist];
    [self dismissViewControllerAnimated:YES completion:nil];
    [Tweaks OpenApp:arr[indexPath.row] name:[Tweaks executablePathFromBundle:arr[indexPath.row]] app:app];
    
}

- (IBAction)find:(id)sender {
    [UIView animateWithDuration:0.5 animations:^(void){
        self.search.hidden=0;
        self.search.frame = CGRectMake(0, self->_navBar.frame.origin.y+self->_navBar.frame.size.height, self->_search.frame.size.width, self->_search.frame.size.height);
        self->_tbl.frame = CGRectMake(self->_tbl.frame.origin.x, self->_search.frame.origin.y+self->_search.frame.size.height, self->_tbl.frame.size.width, self->_tbl.frame.size.height);
    } completion:^(BOOL finished){
        [self.search becomeFirstResponder];
    }];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.5 animations:^(void){
        
        self.search.frame = CGRectMake(0, 0, self->_search.frame.size.width, self->_search.frame.size.height);
        self.search.layer.opacity=0;
        self->_tbl.frame = CGRectMake(self->_tbl.frame.origin.x, ty, self->_tbl.frame.size.width, self->_tbl.frame.size.height);
    } completion:^(BOOL finished){
    self.search.hidden=1;
        
    [self.view endEditing:YES];
    }];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self LoadApplications:searchText];
    [_tbl reloadData];
    

}
@end
//
//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!!!\n\n"
//                      "bla bla vla!"
//                                                message:NULL
//                                               delegate:nil
//                                      cancelButtonTitle:@"No, thanks"
//                                      otherButtonTitles:@"Rate",@"Later",nil];
//[alert show];





