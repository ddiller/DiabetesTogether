//
//  SecondViewController.m
//  MedAppJamApp
//
//  Created by user3656 on 11/10/13.
//  Copyright (c) 2013 Team15. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _videoTable.dataSource = self;
    _videoTable.delegate = self;
    _finished = true;
    VideoFiles* file = [[VideoFiles alloc] initWithURL:@"http://ndep.nih.gov/media/The-Lasting-Impact-of-Gestational-Diabetes-508.mp4" withTitle: @"The Lasting Impact of Gestational Diabetes" asURL:TRUE];
    VideoFiles* file1 = [[VideoFiles alloc] initWithURL: @"diabetes-travel-tips-508" withTitle: @"Diabetes travel tips." asURL:FALSE];
    VideoFiles* file2 = [[VideoFiles alloc] initWithURL:@"eating-healthy-diabetes-gatherings-508" withTitle: @"Eating healthy at gatherings." asURL:FALSE];
    VideoFiles* file3 = [[VideoFiles alloc] initWithURL:@"healthy-eating-diabetes-508" withTitle: @"Eating healthy" asURL:FALSE];

    _tableData = [NSArray arrayWithObjects:file, file1, file2, file3,	 nil];

	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)backButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstButtonPressed:(id)sender
{
////    NSURL *url = [NSURL URLWithString:@"http://ebookfrenzy.com/ios_book/movie/movie.mov"];
////    _player = [[MPMoviePlayerController alloc] initWithContentURL:url];
////    _player.view.frame = CGRectMake(50, 50, 200, 200);
////    [self.view addSubview:_player.view];
////    
////    _player.fullscreen = YES;
////    _player.shouldAutoplay = YES;
////    [_player prepareToPlay];
////    
////    [[NSNotificationCenter defaultCenter] addObserver:self
////                                             selector:@selector(moviePlayBackDidFinish:)
////                                                 name:MPMoviePlayerPlaybackDidFinishNotification
////                                               object:_player];
    _finished = true;
    NSURL *url = [NSURL URLWithString:@"http://ndep.nih.gov/media/The-Lasting-Impact-of-Gestational-Diabetes-508.mp4"];
    _player = [[MPMoviePlayerController alloc]
     initWithContentURL:url];
////    _player.controlStyle = MPMovieControlModeVolumeOnly;
//    [_player prepareToPlay];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieDidStart:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
//
////    _player.shouldAutoplay = YES;
//
//    [self.view addSubview:_player.view];
//    
    [_player setFullscreen:YES animated:NO];
    [_player play];
    [_player setControlStyle:MPMovieControlStyleFullscreen];
//
//
}
//- (IBAction)secondButtonPressed:(id)sender
//{
//    
//}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [_player.view setFrame:CGRectMake(0, 70, 320, 270)];
    } else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [_player.view setFrame:CGRectMake(0, 0, 480, 320)];
    }
    return YES;
}

- (void) movieDidStart:(NSNotification*)notification {
    if (_player.playbackState == MPMoviePlaybackStatePlaying)
    {
        _player.controlStyle = MPMovieControlModeVolumeOnly;
    }
    else if (_player.playbackState == MPMoviePlaybackStateSeekingForward)
    {
        NSLog(@"HEY YOU MOVED YOU JERK");
        _finished = false;
    }
    else if(_player.playbackState == MPMoviePlaybackStateSeekingBackward)
    {
        NSLog(@"HEY YOU MOVED YOU JERK");
        _finished = false;

    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableData count];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    if (_finished)
    {
        [_player setFullscreen:NO];
        [_player stop];
        NSLog(@"You get points!");
    }
    else
    {
        [_player setFullscreen:NO];
        [_player stop];
        NSLog(@"No points for you");
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"Selected something");
      _finished = true;
    if ([[_tableData objectAtIndex:indexPath.row] isURL])
    {
       NSURL *url = [NSURL URLWithString:[[_tableData objectAtIndex:indexPath.row] getURL]];
       _player = [[MPMoviePlayerController alloc]
        initWithContentURL:url];
    }
    else
    {
//        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"diabetes-travel-tips-508" ofType:@"mp4"];
        NSString *filepath =   [[NSBundle mainBundle] pathForResource:[[_tableData objectAtIndex:indexPath.row] getURL] ofType:@"mp4"];
//        NSURL *url = [NSURL fileURLWithPath:filepath];
//        NSURL *url = [NSURL URLWithString:[[_tableData objectAtIndex:indexPath.row] getURL]];
//        NSLog(@"%@", [[_tableData objectAtIndex:indexPath.row] getURL]);
        NSLog(@"%@", filepath);
        _player = [[MPMoviePlayerController alloc]
                   initWithContentURL:[NSURL fileURLWithPath:filepath]];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieDidStart:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    [self.view addSubview:_player.view];

    [_player setFullscreen:YES animated:NO];
    [_player play];
    [_player setControlStyle:MPMovieControlStyleFullscreen];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"videoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [[_tableData objectAtIndex:indexPath.row] getTitle];
    return cell;
}

@end
