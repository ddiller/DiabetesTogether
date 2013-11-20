#import "FacebookViewController.h"
#import "AppDelegate.h"
#import "ShareViewController.h"

@interface FacebookViewController ()
@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *publishButton;

@end

@implementation FacebookViewController

@synthesize publishButton;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Ask for the required permissions
    self.loginView.readPermissions = @[@"basic_info"];
}

- (void)viewDidUnload
{
    [self setPublishButton:nil];
    [self setLoginView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Action methods

- (IBAction)publishButtonAction:(id)sender {
    ShareViewController *viewController = [[ShareViewController alloc]
                                           initWithNibName:@"ShareViewController"
                                           bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - LoginView Delegate Methods
/*
 * Handle the logged in scenario
 */
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.publishButton.hidden = NO;
}

/*
 * Handle the logged out scenario
 */
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.publishButton.hidden = YES;
}

@end
