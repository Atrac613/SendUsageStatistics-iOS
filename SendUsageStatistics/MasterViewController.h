//
//  MasterViewController.h
//  SendUsageStatistics
//
//  Created by Osamu Noguchi on 5/30/12.
//  Copyright (c) 2012 atrac613.io. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MasterViewController : UIViewController <UIAlertViewDelegate>

- (IBAction)buttonPressed:(id)sender;
- (void)showSendUsageStatisticsAlert:(BOOL)force;

@end
