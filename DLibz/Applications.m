//
//  Applications.m
//  DLibz
//
//  Created by iTheGentle on 11/11/17.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import "Applications.h"
#import "CellTableViewCell.h"
#import "AppList/AppList.h"
#import "TweaksTableView.h"
#import "SVProgressHUD.h"
#import "Tweaks.h"
#import "TweakCell.h"
static ALApplicationList *al;
static NSString *plist=@"/var/mobile/Dlibz/list.plist";
@implementation Applications
static NSArray *arr;
static  NSMutableDictionary *dic;
static UITableView *TBL;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerNib:[UINib nibWithNibName:@"CellTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    CellTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIImage *largeIcon = [al iconOfSize:ALApplicationIconSizeLarge forDisplayIdentifier:arr[indexPath.row]];
    cell.icon.image  =largeIcon;
    cell.Display.text= [[dic valueForKey:arr[indexPath.row]] valueForKey:@"Name"];
    cell.contentView.backgroundColor = self.view.backgroundColor;
    return cell;
}

- (void)viewDidAppear:(BOOL)animated{
    
    [_tbl reloadData];
    
    
}
NSTimer *x;
- (void)viewWillAppear:(BOOL)animated{
    al = [NSClassFromString(@"ALApplicationList") sharedApplicationList];
    _tbl.dataSource=self;
    _tbl.delegate=self;
    dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plist];
    if(dic.count !=0){
        arr = [dic allKeys];
    }
    TBL=_tbl;

}

-(void)viewDidLoad{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
    _navBar.frame = CGRectMake(0, [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom, self.view.frame.size.width, _navBar.frame.size.height);

    _tbl.frame =CGRectMake(0, _navBar.frame.size.height + _navBar.frame.origin.y , self.view.frame.size.width,26+ _tbl.frame.size.height - [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom );
    }
    else {
        _navBar.frame = CGRectMake(0, 0, self.view.frame.size.width, _navBar.frame.size.height);

            _tbl.frame =CGRectMake(0, _navBar.frame.size.height + _navBar.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height - _navBar.frame.size.height);
    }
    _navTitle.frame =CGRectMake(_navTitle.frame.origin.x,_navBar.frame.origin.y + 10,_navTitle.frame.size.width,_navTitle.frame.size.height);

        NSDictionary *lang = [[NSDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.apple.springboard.plist"];
        NSString *language = [lang valueForKey:@"XBRecentLocale"];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:language];

        if ([[locale languageCode] isEqualToString:@"ar"]){
            _managedapps.text = @"التحكم بالتطبيقات";
            [_donelabel setTitle: @"تم"];
        }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [TweaksTableView setBundle:arr[indexPath.row]];
    [self performSegueWithIdentifier:@"Tweaks" sender:self];

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [dic removeObjectForKey:[arr objectAtIndex:indexPath.row]];
        [dic writeToFile:plist atomically:NO];
        arr = [[NSMutableArray alloc] initWithArray:arr];
               [(NSMutableArray*)arr removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
    }
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *AppList = [[NSMutableDictionary alloc] initWithContentsOfFile:plist];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [dic removeObjectForKey:[arr objectAtIndex:indexPath.row]];
        [dic writeToFile:plist atomically:NO];
        NSMutableDictionary *bundle = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist"];
        NSMutableArray *hookArr =[[bundle valueForKey:@"Filter"] valueForKey:@"Bundles"];
        [hookArr removeObject:[arr objectAtIndex:indexPath.row]];
        [bundle[@"Filter"] setValue:hookArr forKey:@"Bundles"];
        [bundle writeToFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist" atomically:NO];
        NSMutableDictionary *pref = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/Dlibz.plist"];
        [pref removeObjectForKey:[arr objectAtIndex:indexPath.row]];
        [pref writeToFile:@"/private/var/mobile/Library/Preferences/Dlibz.plist" atomically:NO];
        arr = [[NSMutableArray alloc] initWithArray:arr];
        [(NSMutableArray*)arr removeObjectAtIndex:indexPath.row];
        
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }];
    UITableViewRowAction *reloadAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"reLoad"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        NSMutableDictionary *bundle = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist"];
        NSMutableArray *hookArr =[[bundle valueForKey:@"Filter"] valueForKey:@"Bundles"];
        if([hookArr containsObject:arr[indexPath.row]]){
            [hookArr removeObject:[arr objectAtIndex:indexPath.row]];
                 [bundle[@"Filter"] setValue:hookArr forKey:@"Bundles"];
                 [bundle writeToFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist" atomically:NO];
        }
        [Tweaks updatePlist];
        [Tweaks OpenApp:arr[indexPath.row] name:[Tweaks executablePathFromBundle:arr[indexPath.row]] app:[[dic valueForKey:arr[indexPath.row]] valueForKey:@"Name"]];
        sleep(2);
        [hookArr addObject:arr[indexPath.row]];
        [bundle[@"Filter"] setValue:hookArr forKey:@"Bundles"];
        [bundle writeToFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist" atomically:NO];
        
     }];
    deleteAction.backgroundColor =[UIColor colorWithRed:0.77 green:0.00 blue:0.20 alpha:1.0];
    reloadAction.backgroundColor =[UIColor colorWithRed:0.25 green:0.31 blue:0.84 alpha:1.0];
    
    return @[deleteAction,reloadAction];
}

+(void)reload{
    dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plist];
    if(dic.count !=0){
        arr = [dic allKeys];
    }
    [TBL reloadData];
}
@end
