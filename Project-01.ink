/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR tool = ""
VAR lbs = ""
VAR sticks = 0 
VAR wait = -1

-> weight

=== weight ===
What weight will you be?
*[Under Average]
    ~ lbs = "UAverage"
    -> cave_entrance
*[Average]
    ~ lbs = "Average"
    -> cave_entrance
*[Above Average]
    ~ lbs = "AAverage"
    -> cave_entrance

== cave_entrance ==
{home: You've got your tool now, ready?| You find yourself at a cave intrance. Do you wish to explore?}
* [Explore] -> cave
* [Don't Explore] -> cave_ignore

== cave ==
{As you enter the cave rubble falls blocking you in what do you do?|You are at the rubble and do what?|Wow at the rubble again..|Here again..}
{ wait_wolves() }
* {tool == "Pocket Knife"} [Use your knife] -> use_tool
* {tool == "Phone"} [Use your phone] -> use_tool
* {tool == "Flashlight"} [Use your light] -> use_tool
+ [Try to find supplies] -> search_light
+ {wait <= 2} [Wait for help] -> cave
+ {wait == 3} [Wait for help] -> wolf_attack

=== use_tool ===
{tool == "Pocket Knife": ... What exactly is this going to help with here?..|}
{tool == "Phone": Smart idea use the life 360 app to ping your parents! What now though?|}
{tool == "Flashlight": Oh right your light! You quickly fumble before finding it. Turning it on you realise how useless it is barely reflect little glints in what seem to be the eyes of creatures before it dies..|}
* [Try to find supplies] -> search_light
+ [Wait for help] -> wolf_attack

=== cave_ignore ===
What.. Why?
* [Cause you need your tools duh] -> home
* [Not Interested] -> library

== home ==
You head home but what tool do you grab?
*[Your trusty old pocket knife]
    ~ tool = "Pocket Knife"
    -> cave_entrance
*[Your phone]
    ~ tool = "Phone"
    -> cave_entrance
*[An old flashlight]
    ~ tool = "Flashlight"
    -> cave_entrance

== library ==
Oh well you head to the library.. You leave and remain bored, but safe -> END

== search_light ==
{search_deep: You wonder deeper through the cave system for a bit finding a spot where light shines down through the ceiling|Its feels like its been hours and you begin to lose hope..}
* [Keep on going a little deeper] -> search_deep
+ {search_deep} [Try and climb out] -> upper_cave
+ [Quit and head back] -> cave

== upper_cave ==
You make it half way and feel the struggle creep upon yourself then see a rope just out of your grasp
+ {lbs == "UAverage"}[Reach for it] -> rope_climb_s
+ {lbs != "UAverage"}[Reach for it] -> rope_climb_f
+ [Work through the struggle] -> hilltop

=== rope_climb_s ===
{lbs == "UAverage": You grab the rope and begin your climb!} -> hilltop

=== rope_climb_f ===
You barely manage to grab it before falling to your end as the rope gives to your weight. -> END

== hilltop ==
{lbs == "UAverage": You've made it with no scratches or anything!|You push through the pain knowing the rope was to tattered to help due to your weight and make it out with just a few scatches due to the sharp and difficult climb.}-> END

== search_deep ==
You keep going until.. -> search_light

=== wolf_attack ===
{search: Hurry! What now the wolves are closing in!|You decide your best bet was to wait for help but little did you know there were wolves in the cave.}
+ [Fight Back] -> fight_back
+ {search} [Throw it at the wolves] -> fetch_route
* [Check your surroundings] -> search
+ [Run] -> run

=== search ===
~ sticks = sticks+1
{sticks == 1: You find a stick! You now have {sticks} stick| You find a stick! You now have {sticks} sticks} -> wolf_attack

=== fight_back ===
{sticks > 0 or tool == "Pocket Knife": You manage to fend off the wolves surviving long enough for a group to save you|Wow for real what did you expect their wolves..}
-> END

=== fetch_route ===
Wow.. who would've expected such a stupid outcome.. they chased it those over glorified dogs. You were found playing fetch just a while later perfectly fine in the end. Now that your saved what do you do with those wolves?
* [Keep them] -> idiot
* [Ditch them] -> heartless

=== idiot ===
Well in the end you forsake your entire family to an awful fate afterall the wolves weren't domesticatedwhat will you do now?.
* [Play Fetch] -> safety_fetch
* [Rest after your long adventure] -> danger_rest

=== safety_fetch ===
They're happy.. for now... -> END

=== danger_rest ===
You slept for the rest of your life. All 10 minutes that it took for the wolves to finish your family before moving on to their last sorce of food.. -> END

=== heartless ===
Good call. Does't change the fact you just ditched those poor puppers in the cold darkness of the night -> END

=== run ===
Wow for real what did you expect their wolves.. 
-> END

== function wait_wolves ==

    ~ wait = wait + 1
    
    {
        - wait == 0:
            ~ return "Smart choice"
            
        - wait == 1:
            ~ return "Alright we'll wait some more.."
            
        - wait == 2:
            ~ return "This is boring.."
            
        - wait == 3:
            ~ return "Did you hear that?..."
            
    }
    ~ return wait