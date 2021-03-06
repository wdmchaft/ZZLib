/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

/**
 Check if current device is iPad.
 @return `YES` if it is iPad, `NO` otherwise.
 */
BOOL ZZIsPad();

/**
 Check if current device is iPhone4 with retina display.
 @return `YES` if it is iPhone4 (with retina), `NO` otherwise.
 */
BOOL ZZIsRetina();

// short hand for color creation
#define ZZRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

