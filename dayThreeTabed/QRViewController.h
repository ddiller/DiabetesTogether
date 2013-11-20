//
//  FirstViewController.h
//  MedAppJamApp
//
//  Created by user3656 on 11/10/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface QRViewController : UIViewController <ZBarReaderDelegate>

@property (nonatomic, strong) NSString* key;
@property (nonatomic, strong) NSUserDefaults* userDefaults;
//@property (nonatomic)IBOutlet UIImageView* resultImage;
////@property (nonatomic) IBOutlet UITextView* resultText;
- (IBAction)resetPreferences:(id)sender;
- (IBAction)scanTapped:(id)sender;
//- (IBAction)imageTapped:(id)sender;
- (IBAction)printCode:(id)sender;
@end
