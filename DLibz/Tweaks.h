//
//  Tweaks.h
//  DLibz
//
//  Created by iTheGentle on 11/11/17.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NT.h"
typedef struct {
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *bundle;
    __unsafe_unretained NSString *dylib;
    __unsafe_unretained NSString *descriptionURL;
    __unsafe_unretained NSString *version;
    __unsafe_unretained NSString *status;
    __unsafe_unretained NSString *Description;
} Tweak;
@interface Tweaks : NSObject
+(Tweak)TweakWithBundle:(NSString*)bundle;
+(NSMutableArray*)installedDEB;
+(NSString*)dpkg:(NSString*)cmd;
+(NSString*)ClearString:(NSString*)str;
+(NSString*)BundleFromFile:(NSString*)bundle;
+(NSMutableArray*)GetTweaksListFromProcess:(NSString*)pid;
+(NSString*)GetApplicationPid:(NSString*)exePath;
+(void)OpenApp:(NSString*)bundle name:(NSString*)name app:(NSString*)App;
+(void)CreateDictionaryAt:(NSString*)path withContents:(NSMutableDictionary*)contents bundle:(NSString*)bundle;
+(void)updatePlist;
+(NSString*)executablePathFromBundle:(NSString*)bndl;
+(NSArray*)DependsForBundle:(NSString*)bundle;
+(NSString*)UninstallTweakWithBundle:(NSString*)bndl withSender:(UIButton*)btn;

@end
