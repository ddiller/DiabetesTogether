//
//  SecondViewController.h
//  MedAppJamApp
//
//  Created by user3656 on 11/10/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VideoViewController.h"
#import "VideoFiles.h"

@interface VideoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
//@property (weak, nonatomic) IBOutlet UIButton *SecondMovie;
//@property (weak, nonatomic) IBOutlet UIButton *FirstMovie;
//- (IBAction)firstButtonPressed:(id)sender;
//- (IBAction)secondButtonPressed:(id)sender;
@property (strong, nonatomic) MPMoviePlayerViewController *viewPlayer;
@property (strong, nonatomic) MPMoviePlayerController* player;
@property (assign) BOOL finished;
@property (weak, nonatomic) IBOutlet UITableView *videoTable;
@property (strong, nonatomic) NSArray* tableData;
@end
