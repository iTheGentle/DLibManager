//
//  main.m
//  DLibz
//
//  Created by iTheGentle on 11/11/17.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <dlfcn.h>

void patch_setuid() {
    void* handle = dlopen("/usr/lib/libjailbreak.dylib", RTLD_LAZY);
    if (!handle)
        return;

    // Reset errors
    dlerror();
    typedef void (*fix_setuid_prt_t)(pid_t pid);
    fix_setuid_prt_t ptr = (fix_setuid_prt_t)dlsym(handle, "jb_oneshot_fix_setuid_now");
    
    const char *dlsym_error = dlerror();
    if (dlsym_error)
        return;

    ptr(getpid());
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
       setuid(0);
        setuid(0);
        if(getuid() != 0) patch_setuid();
        setuid(0);
        setuid(0);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
