//
//  SquareGameOverViewController.m
//  Squares
//
//  Created by Romain on 4/6/14.
//
//

#import "UIImage+UIImageAdditions.h"
#import "SquareGameOverViewController.h"
#import "SquareSocialController.h"
#import "SquareScoreManager.h"
#import "defines.h"

@interface SquareGameOverViewController ()

@end

@implementation SquareGameOverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.squareTitle.font = SQUARE_FONT_HUGE;
    self.squareScore.font = SQUARE_FONT_BIG;
    self.squareBestScoreTitle.font = SQUARE_FONT_MEDIUM;
    self.squareBestScore.font = SQUARE_FONT_BIG;
    
    [self.squareFacebookButton setBackgroundImage:[UIImage imageNamed:SQUARE_SMALL_BUTTON withColor:SQUARE_COLOR_CYAN] forState:UIControlStateNormal];
    self.squareFacebookButton.titleLabel.font = SQUARE_FONT_MEDIUM;
    [self.squareFacebookButton setTitleColor:SQUARE_COLOR_CYAN forState:UIControlStateNormal];
    
    [self.squareTryAgainButton setBackgroundImage:[UIImage imageNamed:SQUARE_SMALL_BUTTON withColor:SQUARE_COLOR_ORANGE] forState:UIControlStateNormal];
    self.squareTryAgainButton.titleLabel.font = SQUARE_FONT_MEDIUM;
    [self.squareTryAgainButton setTitleColor:SQUARE_COLOR_ORANGE forState:UIControlStateNormal];
    
    [self.squareQuitButton setBackgroundImage:[UIImage imageNamed:SQUARE_SMALL_BUTTON withColor:SQUARE_COLOR_YELLOW] forState:UIControlStateNormal];
    self.squareQuitButton.titleLabel.font = SQUARE_FONT_MEDIUM;
    [self.squareQuitButton setTitleColor:SQUARE_COLOR_YELLOW forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)postScoreOnFacebook:(id)sender {
    SquareLevelsManager *levelsManager = [SquareLevelsManager sharedSquareLevelsManager];
    
    [[SquareSocialController sharedSquareSocialController] postOnFacebook:levelsManager.squareGameType withScore:self.squareScore.text.integerValue];
}

- (IBAction)restartGame:(id)sender {
    [self dismissAnimatedGameOverView:self.view.superview withCompletion:^(BOOL finished) {
        [self.view removeFromSuperview];
        if (self.squareGameOverViewDelegate)
            [self.squareGameOverViewDelegate restartGame];
    }];
}

- (IBAction)quitGame:(id)sender {
    [self dismissAnimatedGameOverView:self.view.superview withCompletion:^(BOOL finished) {
        [self.view removeFromSuperview];
        if (self.squareGameOverViewDelegate)
            [self.squareGameOverViewDelegate quitGame];
    }];
}

- (void)presentAnimatedGameOverView:(UIView *)parent withCompletion:(void (^)(BOOL))block {
    NSInteger   viewHeight = parent.frame.size.height;

    self.view.frame = CGRectMake(0, viewHeight, parent.frame.size.width, parent.frame.size.height);
    [parent addSubview:self.view];

    SquareScoreManager *scoreManager =[SquareScoreManager sharedSquareScoreManager];
    
    self.squareScore.text = [NSString stringWithFormat:@"%lu", (unsigned long)scoreManager.squareScore];
    self.squareBestScore.text = [NSString stringWithFormat:@"%lu", (unsigned long)[scoreManager getCorrespondingBestScore]];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:block];
}

- (void)dismissAnimatedGameOverView:(UIView *)parent withCompletion:(void (^)(BOOL))block {
    NSInteger   viewHeight = parent.frame.size.height;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.frame = CGRectMake(0, viewHeight, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:block];
}

@end
