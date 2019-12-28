//
//  TweakCell.m
//  DLibz
//
//  Created by iTheGentle on 11/11/17.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import "TweakCell.h"
#import "Tweaks.h"
#import "TweaksTableView.h"
static NSString *plist = @"/private/var/mobile/Library/Preferences/Dlibz.plist";
@implementation TweakCell

+(void)addApplicationWithName:(NSString*)name andBundle:(NSString*)bundle DisabledTweaks:(NSArray*)tweak{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plist];
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    if (dic.count ==0){
        dic = [[NSMutableDictionary alloc] init];
       
        [dic setValue:tweak forKey:@"disabled"];
        [result setObject:dic forKey:bundle];
        
    }
    
    else {
        result=[[NSMutableDictionary alloc] initWithDictionary:dic];
        [result setValue:@{@"disabled":tweak} forKey:bundle];
    }
    [result writeToFile:plist atomically:NO];
}
- (void)awakeFromNib {
    [super awakeFromNib];
  
}
static NSMutableArray *arr;
- (IBAction)status:(id)sender {

    UISwitch *Switch = (UISwitch*)sender;
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plist];
    arr = [[dic valueForKey:_bndle] valueForKey:@"disabled"];
    if(arr.count ==0){
        arr = [[NSMutableArray alloc] init];
    }
    if(![arr containsObject:self.file.text]){
        [arr addObject:self.file.text];
        }
    
    if(Switch.isOn){
        [arr removeObject:self.file.text];

    }
    NSDictionary *hookDic = [[NSDictionary alloc] initWithContentsOfFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist"];
    NSMutableArray *hookArr =[[hookDic valueForKey:@"Filter"] valueForKey:@"Bundles"];
    if(hookArr.count==0){
        hookArr = [[NSMutableArray alloc] init];
    }
    if(![hookArr containsObject:_bndle] && arr.count!=0){
        [hookArr addObject:_bndle];
        [hookDic[@"Filter"] setValue:hookArr forKey:@"Bundles"];
        [hookDic writeToFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist" atomically:NO];
    }

    else if(arr.count==0){
    [hookArr removeObject:_bndle];
    [hookDic[@"Filter"] setValue:hookArr forKey:@"Bundles"];
    [hookDic writeToFile:@"/Library/MobileSubstrate/DynamicLibraries/AppHooker.plist" atomically:NO];
    }
    

    [TweakCell addApplicationWithName:self.name.text andBundle:_bndle DisabledTweaks:arr];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}
- (IBAction)info:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
    NSString *str = [Tweaks BundleFromFile:self.file.text];
    Tweak T = [Tweaks TweakWithBundle:str];
        TweaksTableView *ttv = self.vc;
        ttv.TName = T.name;
        ttv.TWeb = T.descriptionURL;
        ttv.ver = T.version;
        ttv.TDescription = T.Description;
        ttv.Bundle = T.bundle;
        if([T.status isEqualToString:@"install ok installed"])
        {
            [self.vc performSegueWithIdentifier:@"PI" sender:self];

        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"⚠️"
                                                            message:@"Tweak not Installed!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        });
}

@end
