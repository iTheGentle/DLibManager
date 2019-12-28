//
//  TweaksTableView.m
//  DLibz
//
//  Created by iTheGentle on 11/11/17.
//  Copyright © 2018 iTheGentle. All rights reserved.
//
#import "TweakCell.h"
#import "TweaksTableView.h"
#import "Tweaks.h"
#import "PackageInfoViewController.h"
static NSString *plist=@"/var/mobile/Dlibz/list.plist";
NSDictionary *dic;
NSString *b;

@implementation TweaksTableView

+(void)setBundle:(NSString*)arg1{
    b=arg1;
}

-(void)viewDidLoad{
    

        NSDictionary *lang = [[NSDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.apple.springboard.plist"];
        NSString *language = [lang valueForKey:@"XBRecentLocale"];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:language];

        if ([[locale languageCode] isEqualToString:@"ar"]){
            _injectedtweak.text = @"الأدوات المحقونة";
            [_donelabel setTitle:@"تم"];
            _disableall.text =@"تعطيل الكل";
        }
NSDictionary *all = [[NSDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/Dlibz.plist"];
    dic = [[NSDictionary alloc] initWithContentsOfFile:plist];
    dic = [[dic valueForKey:b] valueForKey:@"DYLIBS"];


    if([[[all valueForKey:b] valueForKey:@"ALL"] isEqualToString:@"YES"])
    {

        [self ->_AllDisabled setOn:1];
        
        
    }
    else {
        [self ->_AllDisabled setOn:0];
    }

    _tbl.dataSource=self;
    _tbl.delegate=self;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
    _navBar.frame = CGRectMake(0, [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom, self.view.frame.size.width, _navBar.frame.size.height);

    _tbl.frame =CGRectMake(0, _navBar.frame.size.height + _navBar.frame.origin.y , self.view.frame.size.width,26+ _tbl.frame.size.height - [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom );
    }
    else {
        _navBar.frame = CGRectMake(0, 0, self.view.frame.size.width, _navBar.frame.size.height);

            _tbl.frame =CGRectMake(0, _navBar.frame.size.height + _navBar.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height - _navBar.frame.size.height);
    }
    _navTitle.frame =CGRectMake(_navTitle.frame.origin.x,_navBar.frame.origin.y + 10,_navTitle.frame.size.width,_navTitle.frame.size.height);
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dic.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView registerNib:[UINib nibWithNibName:@"TweakCell" bundle:nil] forCellReuseIdentifier:@"TweakCell"];
    
    TweakCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweakCell"];
    cell.vc = self;
    cell.file.text =[dic allKeys][indexPath.row];
    cell.name.text=[dic allValues][indexPath.row];
    cell.status.tag=indexPath.row;
    cell.bndle = b;
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/Dlibz.plist"];
    NSArray *check = [[dic valueForKey:b] valueForKey:@"disabled"];
    if([check containsObject:cell.file.text])
    {
        [cell.status setOn:0];
    }
    else{
        [cell.status setOn:1];
    }
    if (self -> _AllDisabled.on){
        cell.status.enabled=0;
        _tbl.userInteractionEnabled=0;
    }
    cell.contentView.backgroundColor = self.view.backgroundColor;
    return cell;
}






- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PackageInfoViewController *pvc = segue.destinationViewController;
    pvc.TweakName =_TName;
    pvc.TweakVer = _ver;
    pvc.TweakPage = _TWeb;
    pvc.TweakDescription= _TDescription;
    pvc.TweakBundle =_Bundle;
    
}


- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)DisableAll:(id)sender {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/Dlibz.plist"];
    NSMutableDictionary *hookDic = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist"];
         NSMutableArray *hookArr =[[hookDic valueForKey:@"Filter"] valueForKey:@"Bundles"];
    if (dic.count ==0) dic = [[NSMutableDictionary alloc] init];
    NSArray *disabled = [[dic valueForKey:b] valueForKey:@"disabled"];
    UISwitch *s=(UISwitch*)sender;
    if(s.isOn)
    {for (int i=0; i<_tbl.visibleCells.count; i++) {
        TweakCell *cl = _tbl.visibleCells[i];
        cl.status.enabled=0;
    }
    _tbl.userInteractionEnabled=0;

        if(disabled.count ==0) disabled = [NSArray arrayWithObjects:nil];
        [dic setValue:@{@"disabled":disabled,@"ALL":@"YES"} forKey:b];
        [dic writeToFile:@"/private/var/mobile/Library/Preferences/Dlibz.plist" atomically:NO];
  
           if(hookArr.count==0){
               hookArr = [[NSMutableArray alloc] init];
           }
           if(![hookArr containsObject:b]){
               [hookArr addObject:b];
               [hookDic[@"Filter"] setValue:hookArr forKey:@"Bundles"];
               [hookDic writeToFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist" atomically:NO];
           }
}
    else {

        if([hookArr containsObject:b] && disabled.count==0){
            [hookArr removeObject:b];
            [hookDic[@"Filter"] setValue:hookArr forKey:@"Bundles"];
            [hookDic writeToFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist" atomically:NO];
        }
        for (int i=0; i<_tbl.visibleCells.count; i++) {
            TweakCell *cl = _tbl.visibleCells[i];
            cl.status.enabled=1;
        }
            _tbl.userInteractionEnabled=1;
        [dic setValue:@{@"disabled":disabled,@"ALL":@"NO"} forKey:b];
        [dic writeToFile:@"/private/var/mobile/Library/Preferences/Dlibz.plist" atomically:NO];

    }
    

    
}

@end
