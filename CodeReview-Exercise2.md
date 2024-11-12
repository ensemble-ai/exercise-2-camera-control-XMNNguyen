# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Lynn Nguyen
* *email:* lypnguyen@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect ####
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives.

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification #####
The camera stays locked onto the vessel in every direction and at the center of the screen. This also stays true during hyperspeed. Implementation is perfect, but unfortunately the draw_camera_logic is not on by default. draw_camera_logic can be turned on by default by setting the declaration to true in camera_controller_base. It can also be kept true when the cameras change by changing [this assignment of draw_camera_logic to true](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_selector.gd#L32).

___
### Stage 2 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification #####
The camera auto-scrolls across the map at a constant speed, and when the vessel lags behind too much, it's pushed along by the box edge. This stays true during hyperspeed. However, the vessel appears to lag behind the camera even when the player isn't moving the vessel, and it's like it's being pushed to the left edge slowly. I had this problem too, and it can be fixed by also setting the vessel's speed to the auto-scroll speed when the player isn't moving. Also, draw_camera_logic is not on by default.

___
### Stage 3 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification #####
The camera follows the player at a speed slower than the vessel, and also does not go beyond the leash distance in all directions. It also catches up to the vessel when the player stops moving it. This is also true during hyperspeed. The camera does catch up to the vessel, but it's not centered onto the player when it's done catching up, it's always a short distance behind it. I'm not sure if that's intentional... Also, unfortunately draw_camera_logic is not on by default.  

___
### Stage 4 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification #####
When the vessel is moving, the camera moves ahead of it and doesn't go beyond the leash distance in all directions. This is also true during hyperspeed, though in hyperspeed it looks like the leash increases. There is a slight idle time, and the camera moves back to the player after the idle time ends (though it's a little short so it was hard to catch). Unfortunately, draw_camera_logic is not on by default.

___
### Stage 5 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification #####
When the vessel approaches the speedup push zone on each side, the camera slowly speeds up in the corresponding directions. While the vessel is on the innermost area, the camera does not move. When the vessel is at the edge of the pushbox, the camera moves at it's maximum speed (though it doesn't visibly touch the edge). Implementation is perfect, but unfortunately draw_camera_logic is not on by default.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
The style guide was followed very closely! There's only a few little points that I was able to catch:

* There is only [one line that separates the variables from the methods here](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L7); there should be two.
* [This line](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L27) as well as the one following it are continuations of the direction variable assignment, which has too many indents. Visually it still looks like it's continuing which is fine, but the style guide specifies that only two indents are needed.
* [This comment](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/target_focus_position_lock_lerp.gd#L32) and the following comment both reach over 100 characters (Though they're also just comments, so it's not that big of a deal)
* Some variable assignments in 4_way_push_up.gd are really lengthy and go over the 100 character limit, [especially this one](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/4_way_push_up.gd#L88). Continuing them in the next line with two indents would clear that.

Besides these really small infractions, there weren't any others I could spot. The student followed the style guide incredibly well!

#### Style Guide Exemplars ####
Throughout the camera controllers, the separation between logical segments was very clear and defined with one space, and the naming conventions were followed very well.

* The logical segment separation was followed especially well in 4_way_push_up.gd, [starting from here](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/4_way_push_up.gd#L37). There were a lot of logical segments, but each was separated properly with a space.
* Naming conventions for variables followed snake_case appropriately, such as [here](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/target_focus_position_lock_lerp.gd#L25) and [here](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/4_way_push_up.gd#L11)

Again, the style guide was followed very well. I had a hard time spotting infractions at all!
___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars.

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
There were only very minor infractions for best practices, as the code was organized quite well and I couldn't find logical issues with how the code is written.

* There are a few variables that are declared but go unused, such as [distance_to_target](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L23) and [the speedup_zone draw_camera_logic variables](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/4_way_push_up.gd#L109). These should be removed/commented out when unused.
* Some variable names, like [this one](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/4_way_push_up.gd#L82) are a little long, and that adds a lot to the character count in these lines (though this may also just be my opinion). Abbreviating the words in the variable names will help shorten the character account and name length (like "between" to "btwn", "bottom" to "bot" etc. it may depend on preference).

#### Best Practices Exemplars ####
The code was very well commented and like I mentioned in the style guide exemplars, very well spaced out! That made it easier to read, which I appreciate.

* [Especially here](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/target_focus_position_lock_lerp.gd#L32) and [here](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L34), I wasn't lost while reading the code at all. Yay!
* All camera logic was very well organized, and makes sure to explicitly account for hyperspeed like [here](https://github.com/ensemble-ai/exercise-2-camera-control-XMNNguyen/blob/b71376fc345150c0fbd3b11e2b384f3878686b9e/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L40)

Very well done!!! 
