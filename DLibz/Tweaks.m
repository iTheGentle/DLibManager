//
//  Tweaks.m
//  DLibz
//
//  Created by iTheGentle on 11/11/17.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import "Tweaks.h"
#import "SVProgressHUD.h"
#import "Applications.h"
@interface MBApp
+ (id)appWithBundleID:(id)arg1;
@property (nonatomic, retain) NSString *bundleDir;
- (id)containerDir;
@end
@interface LSApplicationProxy
@property (nonatomic, readonly) NSString *canonicalExecutablePath;
@property (nonatomic, readonly) NSString *bundleIdentifier;
@property(readonly, nonatomic) NSURL *bundleURL;
@property(readonly) NSString * bundleExecutable;
@end
@implementation Tweaks
static NSString* listPlist =@"/var/mobile/Dlibz/list.plist";

+(NSString *)executablePathFromBundle:(NSString *)bndl{
    NSArray *apps = [[NSClassFromString(@"LSApplicationWorkspace") performSelector:NSSelectorFromString(@"defaultWorkspace")] performSelector:NSSelectorFromString(@"allInstalledApplications")];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    for (int i=0; i<apps.count; i++) {
LSApplicationProxy *p = apps[i];
        [dic setValue:[[NSString stringWithFormat:@"%@/%@",p.bundleURL.path,[p bundleExecutable]] stringByReplacingOccurrencesOfString:@"/private" withString:@""] forKey:p.bundleIdentifier];
    }
  
    return [dic valueForKey:bndl];

}
+(NSString*)dpkg:(NSString *)cmd{
    
    NSTask *task = [[NSTask alloc] init];
    NSMutableArray *args = [NSMutableArray array];
    [args addObject:@"-c"];
    [args addObject:cmd];
    [task setLaunchPath:@"/bin/sh"];
    [task setArguments:args];
    NSPipe *opipe = [NSPipe pipe];
    [task setStandardOutput:opipe];
    NSPipe *erroPipe = [NSPipe pipe];
    [task setStandardError:erroPipe];
    [task launch];
    [task waitUntilExit];
    NSFileHandle * read = [opipe fileHandleForReading];
    NSData * dataRead = [read readDataToEndOfFile];
    NSString * stringRead = [[NSString alloc] initWithData:dataRead encoding:NSUTF8StringEncoding];
    
    return stringRead;
}

+(NSString*)ClearString:(NSString *)str{
    str = [str stringByReplacingOccurrencesOfString:@"Name: " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"Package: " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"Depiction: " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"Version: " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"Depiction: " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"Status: " withString:@""];
    return [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

+(NSMutableArray*)installedDEB{
    NSArray *brokenByLines=[[[[self dpkg:@"dpkg --get-selections"] stringByReplacingOccurrencesOfString:@"\t" withString:@""] stringByReplacingOccurrencesOfString:@"install" withString:@""] componentsSeparatedByString:@"\n"];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i=0; i<brokenByLines.count; i++) {
        NSString *str = [NSString stringWithFormat:@"%@",brokenByLines[i]];
        if([str containsString:@"."] && ![str containsString:@"cy+"] && ![str containsString:@"gsc"] && ![str containsString:@"profile.d"]){
            [arr addObject:brokenByLines[i]];
            
        }
    }
    
    return arr;
}


+(Tweak)TweakWithBundle:(NSString *)bundle{
  Tweak T1;
    T1.name = [self ClearString:[self dpkg:[NSString stringWithFormat:@"dpkg-query -s %@ | grep Name",bundle]]];
    T1.bundle = [self ClearString:[self dpkg:[NSString stringWithFormat:@"dpkg-query -s %@ | grep Package",bundle]]];
    T1.descriptionURL =[self ClearString:[self dpkg:[NSString stringWithFormat:@"dpkg-query -s %@ | grep Depiction",bundle]]];
    T1.dylib = [[[self ClearString:[self dpkg:[NSString stringWithFormat:@"dpkg-query -L %@ | grep .dylib",bundle]]] componentsSeparatedByString:@"/"] lastObject];
    T1.version = [self ClearString:[self dpkg:[NSString stringWithFormat:@"dpkg-query -s %@ | grep Version",bundle]]];
    T1.Description = [self ClearString:[self dpkg:[NSString stringWithFormat:@"dpkg-query -s %@ | grep Description",bundle]]];
    T1.status = [self ClearString:[self dpkg:[NSString stringWithFormat:@"dpkg-query -s %@ | grep Status",bundle]]];

    return T1;
}

+(NSString*)BundleFromFile:(NSString*)bundle{
    if([bundle containsString:@"/TweakInject/"]){
    bundle = [NSString stringWithFormat:@"/Library/MobileSubstrate/DynamicLibraries/%@",[bundle lastPathComponent]];
    }
    else{
        bundle=bundle;
    }
    NSArray *arr = [[self ClearString:[self dpkg:[NSString stringWithFormat:@"dpkg-query -S %@",bundle]]] componentsSeparatedByString:@":"];
    return [arr firstObject];
}

+(void)CreateDictionaryAt:(NSString*)path withContents:(NSMutableDictionary*)contents bundle:(NSString *)bundle{
    [contents writeToFile:path atomically:NO];
}


NSMutableDictionary *info;
NSString *str;
+(NSMutableArray*)GetTweaksListFromProcess:(NSString*)pid{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
    str = [self dpkg:[NSString stringWithFormat:@"/Applications/DLibz.app/bin/lsof11 -p %@ | grep %@",pid,@"DynamicLibraries"]];
        if([str isEqualToString:@""]){
    str = [self dpkg:[NSString stringWithFormat:@"/Applications/DLibz.app/bin/lsof11 -p %@ | grep %@",pid,@"TweakInject"]];
        }
    }
    else{
         str= [self dpkg:[NSString stringWithFormat:@"/Applications/DLibz.app/bin/lsof10 -p %@ | grep %@",pid,@"DynamicLibraries"]];
    }
    NSArray *arr1 = [str componentsSeparatedByString:@" /"];
    NSMutableArray *res = [[NSMutableArray alloc] init];

    for (int i =1;i<arr1.count;i++){
        NSArray *arr2 = [arr1[i] componentsSeparatedByString:@"\n"];
        if(![arr2[0]  containsString:@"Frameworks"]){
            [res addObject:[arr2[0] lastPathComponent]];
        }
        
        
    }

    
    return res;
}

+(NSString*)GetApplicationPid:(NSString*)exePath{
    NSString *str = [self ClearString:[self dpkg:[NSString stringWithFormat:@"ps -A | grep \"%@\"",exePath]]];
    str = [str componentsSeparatedByString:@"??"][0];
    
return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
                     
}

+(void)updatePlist{
    infoPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:listPlist];
}

NSMutableDictionary *infoPlist;
+(void)OpenApp:(NSString*)bundle name:(NSString*)name app:(NSString*)App{
    [SVProgressHUD showWithStatus:@"Fishing..."];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self dpkg:[NSString stringWithFormat:@"/Applications/DLibz.app/bin/launchapp %@",bundle]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        [self dpkg:@"/Applications/DLibz.app/bin/launchapp com.iTheGentle.Dlibz"];
            NSMutableArray *arr=  [self GetTweaksListFromProcess:[self GetApplicationPid:name]];
            if(infoPlist.count ==0){
    info = [[NSMutableDictionary alloc] init];
            }
            else{
    info = [[NSMutableDictionary alloc] initWithDictionary:infoPlist];
            }
            for(int i=0;i < arr.count;i++){
                [plist setValue:[self TweakWithBundle:[self BundleFromFile:arr[i]]].name forKey:arr[i]];
                [info setValue:@{@"Name":App,@"DYLIBS":plist} forKey:bundle];
                
            }

            [self CreateDictionaryAt:listPlist withContents:info bundle:bundle];
            [SVProgressHUD showSuccessWithStatus:@"we've done babe :)"];
            NSTask *task = [[NSTask alloc] init];
                       task.launchPath = @"/bin/kill";
                     task.arguments = @[[self GetApplicationPid:name]];


                   [task launch];
                   [task waitUntilExit];
            [Applications reload];
            

});


    });


    

}
+(NSArray*)DependsForBundle:(NSString *)bundle{
    NSMutableArray *clearDeps = [[NSMutableArray alloc] init];
    NSString *ClearStr =[[NSString alloc] init];
      NSArray *arr = [[self ClearString:[self dpkg:[NSString stringWithFormat:@"apt-cache depends %@",bundle]]] componentsSeparatedByString:@"Depends:"];
    for (int i=0; i<arr.count; i++) {
        ClearStr = [arr[i] stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(![ClearStr isEqualToString:bundle] && [ClearStr containsString:@"."]){
            if([ClearStr containsString:@"Conflicts:"]){
                ClearStr = [[ClearStr componentsSeparatedByString:@"Conflicts:"][0] stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }
            [clearDeps addObject:ClearStr];
        }
    }
    return clearDeps;
}


+(NSString*)UninstallTweakWithBundle:(NSString*)bndl withSender:(UIButton*)btn{
    [SVProgressHUD showWithStatus:@"Processing..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
          NSTask *task = [[NSTask alloc] init];
            task.launchPath = @"/usr/bin/apt-get";
          task.arguments = @[@"-y",@"remove",bndl];


        [task launch];
        [task waitUntilExit];
        if(task.terminationStatus !=0){
          [SVProgressHUD showErrorWithStatus:@"Something went wrong!"];
            btn.enabled=1;
        }
        else {
          [SVProgressHUD showSuccessWithStatus:@"Tweak Uninstalled."];
            btn.enabled=1;
        }
        
            

    });


    });
    return str;
}

@end
