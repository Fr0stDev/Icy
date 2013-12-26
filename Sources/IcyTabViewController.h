//
//  IcyTabViewController.h
//  Icy
//
//  Created by Rob Falk on 1/12/11.
//  Copyright 2011 WeAmDev. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IcyTabViewController : UIViewController <UIWebViewDelegate, UINavigationControllerDelegate> {
	
	IBOutlet UIWebView *IcyHome;
	IBOutlet UIWebView *IcyHomeiPad;
    IBOutlet UIActivityIndicatorView *loader;
    
    UIViewController* webViewController;
    

}

@property(nonatomic, retain) IBOutlet UIWebView *IcyHome;
    
- (void)loadWeb;
- (void)webViewGoBack;

@end
