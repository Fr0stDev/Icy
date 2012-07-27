    //
//  IcyTabViewController.m
//  Icy
//
//  Created by Rob Falk on 1/12/11.
//  Copyright 2011 WeAmDev. All rights reserved.
//

#import "IcyTabViewController.h"


@implementation IcyTabViewController


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {//landscape support
	
	return YES;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [IcyHome loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://fr0stdev.co.cc/icy/"]]];
	[IcyHomeiPad loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://fr0stdev.co.cc/icy/"]]];
    
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(checkLoad) userInfo:nil repeats:YES];
    
}

- (void)checkLoad {
    if (IcyHome.loading) {
        [loader startAnimating];
        loader.hidden = NO;
    }
    else if (IcyHomeiPad.loading) {
        [loader startAnimating];
        loader.hidden = NO;
    }
    else {
        [loader stopAnimating];
        loader.hidden = YES;
    }
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
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
