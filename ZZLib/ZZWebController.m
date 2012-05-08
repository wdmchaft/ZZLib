/* 
 * Copyright (c) 2012 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZWebController.h"

@implementation ZZWebController

@synthesize webView = _webView;
@synthesize toolbar = _toolbar;
@synthesize urlString = _urlString;
@synthesize buttonBack = _buttonBack;
@synthesize buttonForward = _buttonForward;
@synthesize buttonReload = _buttonReload;
@synthesize delegate = _delegate;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithURLString:(NSString *)urlString {
    self = [super init];
    if (self) {
        self.urlString = urlString;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [_toolbar release];
    [_webView release];
    [_urlString release];
    [_buttonBack release];
    [_buttonForward release];
    [_buttonReload release];
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
    [super loadView];
    
    [self setupToolbar];
    
    _webView = [[UIWebView alloc] initWithFrame:
                CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - _toolbar.frame.size.height)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_webView];
    
    NSURL* url = [NSURL URLWithString:_urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    [self updateButtonsStatus];
    
    if ([_delegate respondsToSelector:@selector(webControllerDone:)]) {
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(actionDone:)] autorelease];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setupToolbar {
    _buttonBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] 
                                                                    style:UIBarButtonItemStylePlain 
                                                                   target:self 
                                                                   action:@selector(actionBack:)];
    
    _buttonForward = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forw.png"] 
                                                                    style:UIBarButtonItemStylePlain 
                                                                   target:self 
                                                                   action:@selector(actionForward:)];
    
    _buttonReload = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                                  target:self action:@selector(actionReload:)];
    
    UIBarButtonItem* space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                            target:nil action:nil] autorelease];
    
    _toolbar = [[UIToolbar alloc] initWithFrame:
                CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    _toolbar.barStyle = UIBarStyleBlack;
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_toolbar setItems:[NSArray arrayWithObjects:_buttonBack, space, _buttonForward, space, _buttonReload, nil]];
    
    [self.view addSubview:_toolbar];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIWebViewDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	self.navigationItem.rightBarButtonItem = nil;
    [self updateButtonsStatus];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)webViewDidStartLoad:(UIWebView *)webView {
	[self showActivity];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Toolbar Button Actions
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)actionBack:(id)sender {
    [_webView goBack];
}

- (void)actionForward:(id)sender {
    [_webView goForward];
}

- (void)actionReload:(id)sender {
    [_webView reload];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Other Methods
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showActivity {
	UIActivityIndicatorView* activity = [[[UIActivityIndicatorView alloc] 
										  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite] autorelease];
	[activity startAnimating];
	self.navigationItem.rightBarButtonItem = 
	[[[UIBarButtonItem alloc] initWithCustomView:activity] autorelease];	
}

- (void)updateButtonsStatus {
    _buttonBack.enabled = _webView.canGoBack;
    _buttonForward.enabled = _webView.canGoForward;
}

- (void)actionDone:(id)sender {
    if ([_delegate respondsToSelector:@selector(webControllerDone)]) {
        [_delegate webControllerDone:self];
    }
}

@end
