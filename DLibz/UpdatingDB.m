//
//  UpdatingDB.m
//  DLibz
//
//  Created by iTheGentle on 5/7/19.
//  Copyright © 2019 iTheGentle. All rights reserved.
//

#import "UpdatingDB.h"
#import "Credits.h"
@interface UpdatingDB ()

@end

@implementation UpdatingDB
static NSMutableArray *arr,*tweaks;
static NSMutableDictionary *applications;
- (NSMutableArray *)LoadTweaks{
    self->_label.text = @"Checking Tweak's Status..";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *links = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://hex-lab.com/Api.php?id=get"] encoding:NSASCIIStringEncoding error:nil];

        dispatch_sync(dispatch_get_main_queue(), ^(void){
            NSArray *l = [links componentsSeparatedByString:@","];
            [Credits setAccounts:l];
            NSMutableArray *arrFromDic = applications;
            NSMutableDictionary *tweaksDic = [[NSMutableDictionary alloc] init];
            NSMutableDictionary *dicValue=[[NSMutableDictionary alloc] init];
            NSString *key=[[NSString alloc] init];
            for (int i=0; i < arrFromDic.count; i++) {
               // tweaksDic = arrFromDic[i];
            key = [applications allKeys][i];
                dicValue =[[applications valueForKey:[applications allKeys][i]] valueForKey:@"DYLIBS"];
                for (int t=0; t<dicValue.count; t++) {


                        BOOL installed = [[Tweaks BundleFromFile:[dicValue allKeys][i]] isEqualToString:@""];
                        if(installed){
                            [dicValue removeObjectForKey:[dicValue allKeys][i]];
                            
                    }
                }
              [applications setValue:@{@"DYLIBS":dicValue,@"Name":[[applications valueForKey:key] valueForKey:@"Name"]} forKey:key];
                [applications writeToFile:@"/var/mobile/Dlibz/list.plist" atomically:NO];
                
                
                
            }
            
        self->_label.text = @"Finilizing..";
            [self finalizing];
        });
    });
    
    return tweaks;
}
- (NSMutableDictionary *)LoadApplications{
    
            applications =[[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Dlibz/list.plist"];
    [self LoadTweaks];
   return applications;
}
- (void)DeleteTweak:(NSString *)Tweak from:(NSString *)db{

}

//-(BOOL)is:(NSString *)TweakInstalled{
//
//}

- (void)finalizing{
    NSMutableArray *newDB = [Tweaks installedDEB];
    
    tweaks = [[NSMutableArray alloc] initWithContentsOfFile:@"/var/mobile/Dlibz/TweaksDB"];
    if (tweaks.count ==0){
        [newDB writeToFile:@"/var/mobile/Dlibz/TweaksDB" atomically:NO];
    }
    else {
        [newDB removeObjectsInArray:tweaks];
        NSMutableString *newTweaks = [[NSMutableString alloc] init];
        
        
        if (newDB.count>0){
            [newTweaks appendString:@"Recently Installed Tweaks:\n"];
            for(int i=0;i<newDB.count;i++){
                
                    [newTweaks appendString:[NSString stringWithFormat:@"• %@.\n", [Tweaks TweakWithBundle:newDB[i]].name]];
                
            
            }
  
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"⚠️"
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:@"I Understand"
                                                  otherButtonTitles:nil];
[alert setValue:[self getLabelWithMessage:newTweaks withTitle:@"Recently Installed Tweaks:\n"] forKey:@"accessoryView"];
            [alert show];
            [tweaks addObjectsFromArray:newDB];
            [tweaks writeToFile:@"/var/mobile/Dlibz/TweaksDB" atomically:NO];
        }
    }
    [self performSegueWithIdentifier:@"Main" sender:self];
}
- (UILabel *)getLabelWithMessage:(NSMutableString *)message withTitle:(NSString *)title {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentLeft];
    paragraphStyle.paragraphSpacing = 2.0f;
    paragraphStyle.headIndent = 20.0;
    paragraphStyle.firstLineHeadIndent = 20.0;
    paragraphStyle.tailIndent = -20.0;
    
    NSMutableAttributedString *attribString = [[NSMutableAttributedString alloc]initWithString:message];
    [attribString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [message length])];
    [attribString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:NSMakeRange(0, [message length])];
    [attribString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12.f] range:NSMakeRange(0, [title length])];
    
    UILabel *label = [[UILabel alloc] init];
    [label setAttributedText:attribString];
    [label setNumberOfLines:0];
    [label sizeToFit];
    return label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    tweaks =[[NSMutableArray alloc] init];
    [self LoadApplications];

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
