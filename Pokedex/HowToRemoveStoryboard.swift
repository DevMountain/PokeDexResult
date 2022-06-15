//
//  HowToRemoveStoryboard.swift
//  Pokedex
//
//  Created by Colton Swapp on 6/15/22.
//

// MARK: - Here are the steps for removing storyboard when beginning this project

// STEP 1.
    // Right-click & delete the Main.storyboard file

// STEP 2.
    // Open the Info.plist file for this project, do some toggling
    // Locate the 'Application Scene Manifest' and toggle the dropdown
        // Now toggle down the 'Scene Configuration'
        // Then toggle down the 'Application Session Role'
        // Next, toggle down the 'Item 0(Default Configuration)'
        // Finally, we can remove the key for 'Storyboard Name'
        // Remember, simply deleting the value will not work, we must delete the entire key

// STEP 3.
    // We must do the same thing for the Info.plist file that belongs to our Target
    // Head to our target, location the 'Application Scene Manifest' and copy step 2.

// STEP 4.
    // The Scene Delegate is what is responsible for windows and scenes in our app
    // What is a Window? "The backdrop for your app’s user interface and the object that dispatches events to your views.... You use windows only when you need to do the following: 1. Provide a main window to display your app's content. 2. Create additional windows (as needed) to display additional content."
    // That being said, we need to create a window to show our content
    // In the 'willConnectTo' method of our SceneDelegate, we are going to do the following:
        // Make sure that we have a windowScene
        // Intialize a UIWindow with said scene
        // Assign the root view controller of our scene
        // Make the window visible, as well as make it the key window using the method 'makeKeyAndVisible()' method
        // Finally, we can assign the winow property on the SceneDelegate to the window that we created
    
    // If you are seeing a black screen, be sure to set your viewController.backroundColor to .systemBackground to show white in light mode and black in dark mode
