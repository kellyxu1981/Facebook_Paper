//
//  MainViewController.m
//  HomeWork4
//
//  Created by Kelly Xu on 3/28/14.
//  Copyright (c) 2014 iosbootcamp. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *menuView;
@property (strong, nonatomic) IBOutlet UIView *headlineView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,assign) float distanceFromFrameY;
//@property (nonatomic,assign) NSArray *myImages;

- (IBAction)onPanning:(UIPanGestureRecognizer *)sender;


@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.distanceFromFrameY = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.contentSize = CGSizeMake(1500, 257);
    self.imageView.image = [UIImage imageNamed:@"headline0"];
    
//    NSTimer *imageTimer = [NSTimer scheduledTimerWithTimeInterval:(5.0) target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
//    self.myImages=[NSArray arrayWithObjects:@"headline0",@"headline1",@"headline2",@"headline3",nil];
//    [imageTimer fire];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPanning:(UIPanGestureRecognizer *)sender {
    CGPoint velocity = [sender velocityInView:self.view];
    CGPoint location = [sender locationInView:self.view];
    CGRect frame = self.headlineView.frame;
    if (sender.state == UIGestureRecognizerStateEnded||sender.state == UIGestureRecognizerStateCancelled){
        self.distanceFromFrameY = 0;
        if (velocity.y>0) {
            frame.origin.y  = self.view.frame.size.height - 40;
            [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.headlineView.frame = frame;
                self.menuView.alpha =1;
            } completion:nil];
        }else if(velocity.y<0){
            frame.origin.y = 0;
            [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.headlineView.frame = frame;
                self.menuView.alpha = 0;
            } completion:nil];
        }
    }else if (sender.state == UIGestureRecognizerStateChanged){
        self.menuView.alpha = frame.origin.y/(self.view.frame.size.height-40);
        NSLog(@"menuView alpha = %f",self.menuView.alpha);
        if (self.distanceFromFrameY == 0) {
            self.distanceFromFrameY = location.y - frame.origin.y;
            NSLog(@"travelDistance = %f",self.distanceFromFrameY);
        }
        frame.origin.y = location.y - self.distanceFromFrameY;
        NSLog(@"touch y = %f",location.y);
        NSLog(@"frame y = %f",frame.origin.y);
        self.headlineView.frame = frame;
    }
}

//- (void)changeImage {
//    NSLog(@"changeImage is called");
//    static int i=0;
//    
//    if (i == 4){
//        i=0;
//    }
//    
//    self.imageView.alpha=1;
//    NSLog(@"Index is %d", i);
//    self.imageView.image =[UIImage imageNamed:[self.myImages objectAtIndex:i]];
//    i++;
//
//}

@end
