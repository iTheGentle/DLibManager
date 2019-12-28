//
//  MainVC.h
//  DLibz
//
//  Created by iTheGentle on 10/24/18.
//  Copyright © 2018 iTheGentle. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainVC : UIViewController
-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@property (weak, nonatomic) IBOutlet UIButton *letsgo;
@property (weak, nonatomic) IBOutlet UIButton *buyheragift;
@property (weak, nonatomic) IBOutlet UIButton *credits;
@property (weak, nonatomic) IBOutlet UIButton *contactme;
@property (weak, nonatomic) IBOutlet UIButton *smash;



@end


