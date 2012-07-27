//
//  BackupController.m
//  Icy
//
//  Created by Fr0st on 9/4/11.
//  Copyright 2011 WeAmDev. All rights reserved.
//

#import "BackupController.h"
#import "NSTask.h"
#import "ASIFormDataRequest.h"


@implementation BackupController

/*
- (IBAction)generateBackup {
	
	NSString* UDID = [[UIDevice currentDevice]uniqueIdentifier];
	NSString* backupCMD = [NSString stringWithFormat:@"dpkg --get-selections > /Applications/Icy.app/backup.txt",UDID];
	
	system([backupCMD UTF8String]);
 
	NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@-backup",UDID] ofType:@"txt"]];
	NSString *urlString = @"http://fr0stdev.co.cc/test/new_system.php";
   // NSString *urlString = @"http://weamdev.t15.org/backups/upload.php";
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
    
  
	NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
	//NSString *boundary = nil;
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
	[request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
	
	NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //HOW THE FUCK DO I AUTHENTICATE THIS SHIT?!
    
	[body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@-backup\"\n",UDID]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
	[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[NSData dataWithData:data]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[request setHTTPBody:body];
	
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	
	NSLog(@"%@", returnString);	
	UIAlertView *feedback = [[UIAlertView alloc]
							   initWithTitle:@"Icy Backups" message:[NSString stringWithFormat:@"%@",returnString]
							   delegate:self 
							   cancelButtonTitle:@"OK" 
							   otherButtonTitles:nil];
	
	[feedback show];
	[feedback release];
}
*/
 

-(IBAction)generateBackup {
    
    NSString* UDID = [[UIDevice currentDevice]uniqueIdentifier];
	NSString* backupCMD = [NSString stringWithFormat:@"dpkg --get-selections > /Applications/Icy.app/backup.txt",UDID];
    
	
	system([backupCMD UTF8String]);
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"backup"] ofType:@"txt"]];
    
    //NSURL *url = [[[NSURL alloc] initWithString:@"http://fr0stdev.co.cc/test/new_system.php"] autorelease];
    NSURL *url = [[[NSURL alloc] initWithString:@"http://weamdev.co.cc/backups/upload.php"] autorelease];
    
        ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] 
                                            initWithURL:url] autorelease]; 

            
            [request setPostValue:@"dottie" forKey:@"txtPassword"];
            [request setData:data withFileName:[NSString stringWithFormat:@"%@-backup.txt",UDID] andContentType:@"text/plain" forKey:@"userfile"];
            [request setDelegate:self]; 
            [request startSynchronous]; 
    
}

- (void)requestFinished:(ASIFormDataRequest *)request 
{ 
    NSString *responseString = [request responseString]; 
    NSLog(@"%@",responseString); 
    
    UIAlertView *feedback = [[UIAlertView alloc]
                             initWithTitle:@"Icy Backups" message:[NSString stringWithFormat:@"%@",responseString]
                             delegate:self 
                             cancelButtonTitle:@"OK" 
                             otherButtonTitles:nil];
	
	[feedback show];
	[feedback release];
} 

- (void)requestFailed:(ASIHTTPRequest *)request 
{ 
    //NSError *error = [request error]; 
    
    NSString *responseString = [request responseString]; 
    
    NSLog(@"%@",responseString); 
   
    
    UIAlertView *feedback = [[UIAlertView alloc]
                             initWithTitle:@"Icy Backups" message:[NSString stringWithFormat:@"%@",responseString]
                             delegate:self 
                             cancelButtonTitle:@"OK" 
                             otherButtonTitles:nil];
	
	[feedback show];
	[feedback release];
    
    
} 



-(IBAction)downloadBackup {
        UIAlertView *DLAlert = [[UIAlertView alloc] initWithTitle:@"Icy Backups" message:@"Would you like to download your backup file from the server?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [DLAlert show];
        [DLAlert release];
	DLProgress.hidden = NO;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == 0) {
        if (buttonIndex == 1) {
			NSString* UDID = [[UIDevice currentDevice]uniqueIdentifier];
            progressLabel.text = @"0 Bytes";
            DLProgress.progress = 0.0f;
            //NSURL *dlURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://fr0stdev.co.cc/test/%@-backup.txt",UDID]];
            NSURL *dlURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://weamdev.co.cc/backups/%@-backup.txt",UDID]];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:dlURL];
            NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:true];
            [connection release];
            [request release];
            [dlURL release];
            receivedData = [[NSMutableData alloc] init];
            
        }
		
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (data != nil) {
        [receivedData appendData:[[NSData alloc] initWithData:data]];    
    }
    progressLabel.text = [NSString stringWithFormat:@"%d Bytes",[receivedData length]];
    if (estimatedLength <= 0) {
        return;
    }
    // UPDATE : Here was an error, that caused the progressview not to update properly - Greg has fixed the problem
    float a = [receivedData length];
    float b = estimatedLength;
    NSNumber *progress = [NSNumber numberWithFloat:a/b];
    
    DLProgress.progress = [progress floatValue];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The download failed!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
    [receivedData release];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Finished" message:@"Download completed!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
	[self saveData:receivedData toFile:@"backup.txt"];
    
    
    [receivedData release];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    estimatedLength = [response expectedContentLength];
}
-(void)saveData:(NSMutableData *)data toFile:(NSString *)file {
	NSFileManager* savePath = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
	NSString *temp = [paths objectAtIndex:0];
    temp = [temp stringByAppendingPathComponent:file];
    [data writeToFile:temp atomically:true];
}

-(IBAction)restorePackages {
    
    UIAlertView* loadingAlert = [[UIAlertView alloc] initWithTitle:@"Loading...\nPlease Wait." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [loadingAlert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(loadingAlert.bounds.size.width / 2, loadingAlert.bounds.size.height - 50);
    [indicator startAnimating];
    [loadingAlert addSubview:indicator];
    
	system("/usr/bin/icyrestore");
    
    [loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
    [loadingAlert release];
    
  /*
    NSTask *task = [[[NSTask alloc] init] autorelease];
	[task setLaunchPath:@"/var/mobile/Icy/restore"];
	[task setArguments:nil];
	[task launch];
	[task waitUntilExit];
   */

    
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Restore Finished!" message:@"Your Packages have been restored to your device. Please reboot your iPhone immediately!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
     
        
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	
	
}
 */



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//UIImage* dotty = [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DottyBackground" ofType:@"png"]]];
	//self.view.backgroundColor = [UIColor colorWithPatternImage:dotty];
	
	NSFileManager* backupFile = [NSFileManager defaultManager];
	if ([backupFile fileExistsAtPath:@"/var/mobile/Documents/backup.txt"]) {
		restoreButton.hidden = NO;
		restoreLabel.hidden = NO;
	}
	else {
		restoreButton.hidden = YES;
		restoreLabel.hidden = YES;
	}
	DLProgress.hidden = YES;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
