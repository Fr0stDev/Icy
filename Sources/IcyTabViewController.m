    //
//  IcyTabViewController.m
//  Icy
//
//  Created by Rob Falk on 1/12/11.
//  Copyright 2011 WeAmDev. All rights reserved.
//

#import "IcyTabViewController.h"


@implementation IcyTabViewController
@synthesize IcyHome;


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

    [IcyHome setDelegate:self];
    [IcyHomeiPad setDelegate:self];
    
    self.navigationItem.title = @"Icy Installer";
    
    [self loadWeb];
    
}

-(void)webViewGoBack {
    [IcyHome goBack];
}
    
-(void)loadWeb {
    
    NSLog(@"Loading Website");
    
    [IcyHome loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://fr0st.me/icy/index.html"]]];
	[IcyHomeiPad loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://fr0st.me/icy/index.html"]]];
}

- (void)updateBackButton {
    if ([self.IcyHome canGoBack]) {
        if (!self.navigationItem.leftBarButtonItem) {
            [self.navigationItem setHidesBackButton:YES animated:YES];
            
            UIBarButtonItem *backItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backWasClicked:)] autorelease];
            [self.navigationItem setLeftBarButtonItem:backItem animated:YES];
        }
    }
    else {
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
        [self.navigationItem setHidesBackButton:NO animated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self updateBackButton];
    [loader startAnimating];
   
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:loader];
    [self.navigationItem setRightBarButtonItem:barButton];
    
    loader.hidden = NO;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self updateBackButton];
    [loader stopAnimating];
    loader.hidden = YES;
    
    //UIView *theWindow = [self.view superview];
    
    // remove the current view and replace with myView1
    [IcyHome removeFromSuperview];
    [self.view addSubview:IcyHome];
    
    // set up an animation for the transition between the views
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[IcyHome layer] addAnimation:animation forKey:@"PushWebView"];
    
    NSString* title = [webView stringByEvaluatingJavaScriptFromString: @"document.title"];
    
    self.navigationItem.title = title;
}

- (void)backWasClicked:(id)sender {
    if ([self.IcyHome canGoBack]) {
        [self.IcyHome goBack];
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
