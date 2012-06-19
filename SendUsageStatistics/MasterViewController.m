//
//  MasterViewController.m
//  SendUsageStatistics
//
//  Created by Osamu Noguchi on 5/30/12.
//  Copyright (c) 2012 atrac613.io. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController () {
    
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationItem setTitle:@"Send Usage Statistics"];
    
    GA_TRACK_CLASS
    
    [self showSendUsageStatisticsAlert:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)buttonPressed:(id)sender {
    [self showSendUsageStatisticsAlert:YES];
}

- (void)showSendUsageStatisticsAlert:(BOOL)force {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![[defaults objectForKey:SEND_USAGE_STATISTICS_ALERT_KEY] boolValue] || force) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] message:NSLocalizedString(@"SEND_USAGE_STATISTICS", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"NO", @"") otherButtonTitles:NSLocalizedString(@"YES", @""), nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:SEND_USAGE_STATISTICS_ALERT_KEY];
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:SEND_USAGE_STATISTICS_KEY];
        [defaults synchronize];
        
        [[GANTracker sharedTracker] startTrackerWithAccountID:GA_TRACKING_ID
                                               dispatchPeriod:kGANDispatchPeriodSec
                                                     delegate:nil];
    } else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:SEND_USAGE_STATISTICS_ALERT_KEY];
        [defaults setObject:[NSNumber numberWithBool:NO] forKey:SEND_USAGE_STATISTICS_KEY];
        [defaults synchronize];
        
        [[GANTracker sharedTracker] stopTracker];
    }
}

@end
