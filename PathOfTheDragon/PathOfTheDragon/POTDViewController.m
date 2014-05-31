//
//  POTDViewController.m
//  PathOfTheDragon
//
//  Created by Markus Kammerhofer on 30.05.14.
//  Copyright (c) 2014 Markus Kammerhofer. All rights reserved.
//

#import "POTDViewController.h"
#import "POTDMyScene.h"

@implementation POTDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Set background of the view
    //CGRect currentFrame = CGRectMake(0,0,15360,15360);
    //UIImageView *imageView = [[UIImageView alloc] initWithFrame:currentFrame];
    //UIImage *background = [UIImage imageNamed:@"Map.png"];
    //imageView.image = background;
    //[self.view addSubview:imageView];
    
    // Create and configure the scene.
    SKScene * scene = [[POTDMyScene alloc] initWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
