//
//  SBViewController.m
//  MyTestApp91
//
//  Created by Pooja Kamath on 23/06/14.
//  Copyright (c) 2014 Pooja Kamath. All rights reserved.
//

#import "SBViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface SBViewController ()
@property (weak, nonatomic) IBOutlet UIButton *tweetButton;

- (IBAction)tweet:(id)sender;
@end

@implementation SBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
     [self requestTwitterAccess];
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tweet:(id)sender {
    
    //show the tweet sheet on clicking the button tweet
    [self showTweetSheet];
    
}

- (void)requestTwitterAccess {
    
       ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    ACAccountType *twitterAccount = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    
    [accountStore requestAccessToAccountsWithType:twitterAccount options:nil completion:^(BOOL granted, NSError *error) {
        if (granted) {
            //granted access to account
            NSLog(@"the request is granted!");
        }
        else {
            //something went wrong
            NSLog(@"access to account not granted");
        }}];
    
}

- (void)showTweetSheet
{
    //  Create an instance of the Tweet Sheet
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:
                                           SLServiceTypeTwitter];
    
    // Sets the completion handler
    tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
        switch(result) {
                //  This means the user cancelled without sending the Tweet
            case SLComposeViewControllerResultCancelled:
                break;
                //  This means the user hit 'Send'
            case SLComposeViewControllerResultDone:
                NSLog(@"posted");
                break;
        }
    };
    
       //  Presents the Tweet Sheet to the user
    [self presentViewController:tweetSheet animated:NO completion:^{
        NSLog(@"Tweet sheet has been presented.");
    }];
}





@end
