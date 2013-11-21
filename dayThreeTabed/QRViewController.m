//
//  FirstViewController.m
//  MedAppJamApp
//
//  Created by user3656 on 11/10/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "QRViewController.h"

@interface QRViewController ()

@end

@implementation QRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _userDefaults = [NSUserDefaults standardUserDefaults];

    if ([self keyExists])
    {
        NSLog(@"Key is not null: %@", _key);
        _key = [_userDefaults objectForKey:@"Key"];
    }
    else
    {
        NSLog(@"Key is null");
    }
    
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)clickLight:(id)sender {
    [self showAlert:@"Classes" withMessage:@"Earn 100 points for attending a Diabetes education class!  When you attend an educational class on Diabetes at any one of our partner hospitals there will be a “QR code” available at the end of the class.  The QR code looks like a little box filled in with small black and white squares.  Press the “scan” button and hold the phone up next to the QR code and we will record your attendance.  Ask the Diabetes Education Instructor for the code at the end of the class to start racking up points.  "];
}
-(void)showAlert:(NSString*)title withMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetPreferences:(id)sender {
    NSLog(@"Key was: %@", [_userDefaults objectForKey:@"Key"]);
    [_userDefaults setObject:@"" forKey:@"Key"];
    NSLog(@"Key has been reset! It is now: %@", [_userDefaults objectForKey:@"Key"]);
    [_userDefaults removeObjectForKey:@"Key"];
    _key = @"";
}

-(BOOL)keyExists
{
    return ([[[_userDefaults dictionaryRepresentation] allKeys] containsObject:@"Key"]);

}

- (IBAction)scanTapped:(id)sender
{
    // Present a barcode reader that scans from the camera feed
    ZBarReaderViewController* reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner* scanner = reader.scanner;
    
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: Disalble rarely used I2/5 to improve performance
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
    // Present and release the controller
    [self presentViewController:reader animated:YES completion:NULL];
}

- (void) imagePickerController:(UIImagePickerController *)reader didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol* symbol = nil;
    for (symbol in results)
        // EXAMPLE: Jut grab the first barcode
        break;
    
    // EXAMPLE: Do something useful with the barcode data
//    _resultText.text = symbol.data;
    NSLog(@"%@", symbol.data);
//
//    
//    if ([symbol.data rangeOfString:@"Allen Roman"].location == NSNotFound)
//    {
//        _key = @"Allen Roman";
//        NSLog(@"Key was: %@", [_userDefaults objectForKey:@"Key"]);
//        [_userDefaults setObject:_key forKey:@"Key"];
//        NSLog(@"Key is: %@", [_userDefaults objectForKey:@"Key"]);
//        NSLog(@"It's not here!");
//    }
//    
//    else
//    {
//        NSLog(@"You're here!");
//    }
    if ([self keyExists])
    {
        NSLog(@"QR Key is: %@", _key);
    }
    else
    {
        _key = [symbol.data substringToIndex:15];
        [_userDefaults setObject:_key forKey:@"Key"];
        NSLog(@"QR Key is: %@", _key);
    }
    
    NSLog(@"%@", _key);
    if ([symbol.data rangeOfString:_key].location == NSNotFound)
    {
        NSLog(@"%@", [symbol.data substringToIndex:15]);
        NSLog(@"I see nothing here! Invalid QR code!");
    }
    else
    {
        NSLog(@"Valid code!");
    }
    
    // EXAMPLE: Do something useful with the barcode image
//    _resultImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // ADD : Disiss the controller (NB dismiss from the reader!)
    [reader dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)printCode:(id)sender {
    NSLog(@"Code is: %@", _key);
}
@end
