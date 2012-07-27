//
//  BackupController.h
//  Icy
//
//  Created by Fr0st on 9/4/11.
//  Copyright 2011 WeAmDev. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BackupController : UIViewController {
	IBOutlet UIView* backgroundView;
	IBOutlet UIProgressView *DLProgress;
	IBOutlet UILabel *progressLabel;
	NSMutableData *receivedData;
	float estimatedLength;
	IBOutlet UIButton *restoreButton;
	IBOutlet UILabel *restoreLabel;
    
    IBOutlet UITextField* BackupID;


}
-(IBAction)generateBackup;
-(IBAction)downloadBackup;
-(IBAction)restorePackages;

@end


