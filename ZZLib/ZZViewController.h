/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

/** 
 Short hand for creation of view controller with white view stretched to 
 full screen and with support of all interface orientations.
 
 Please see Demo part of ZZLib project as a best example of the usage: 
 
 - https://github.com/iutinvg/ZZLib/blob/master/Demo/ZZDemoViewController.h
 - https://github.com/iutinvg/ZZLib/blob/master/Demo/ZZDemoViewController.m
 */
@interface ZZViewController : UIViewController {
    /**
     The view instance which is used for in [ZZViewController showLoading:]
     */
	UIView* _loadingView;
}

/** 
 Creates/removes a view for visualizing of loading process.
 
 You will need it in case of usage this class in pair with ZZJSONRequest or similar.
 Default implementation is very simple: white background with activity indicator in the center.
 Please override if necessary. It is not necessary to involve the super class method in your one,
 though you may of course.
 
 Override example:
    - (void)showLoading:(BOOL)flag {
        if (flag) {
            _loadingView = [[UIView alloc] init]; // create a custom view due to design
            [self.view addSubview:_loadingView];
            return;
        }
        // "NO" branch just removes/releases _loadingView from self.view
        // we can reuse it
        [super showLoading:flag];
    }
 
 Usage example:
    - (void)viewDidLoad {
        [super viewDidLoad];
        // starting load loading process here
        [self showLoading:YES];
    }
 
 @param flag `YES` to creates loading view, `NO` to remove
 */
- (void)showLoading:(BOOL)flag;

@end
