//
//  SquareMenuViewController.h
//  Squares
//
//  Created by Romain on 4/4/14.
//
//

#import <UIKit/UIKit.h>

@interface SquareMenuViewController : UIViewController {
    CADisplayLink   *_squareMenuLoop;
    CFTimeInterval  _squareElapsedTime;
}


@property (weak, nonatomic) IBOutlet UIButton *squareMainModeButton;
@property (weak, nonatomic) IBOutlet UIButton *squareHardCoreButton;
@property (weak, nonatomic) IBOutlet UIButton *squareOptionsButton;

@end
