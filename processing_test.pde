# User Ctrl+Alt+K for running the processing command file
# import numpy
import time
import math
import random
# class My_Class():
#
#    def __init__(self):
#        self.x = 480
#        self.y = 120
#
#A = My_Class()

class Point():
    def __init__(self,x,y,type=None):
        self.x = x
        self.y = y
        self.type = type
    
    def move(self, mouse_movement = None):
        if mouse_movement is None:    
            self.x = (self.x + random.randint(-2, 2)) % 600
            self.y = (self.y + random.randint(-2, 2)) % 400

        else:
            self.x = mouseX
            self.y = mouseY
    ## Rock = red
    ## Paper = white
    ## Scissor = green 
    def compare(self,color1,color2):
        if (color1 + color2) == "redgreen" or (color1 + color2) == "greenred":
            return "red"
        if (color1 + color2) == "redwhite" or (color1 + color2) == "whitered":
            return "white"
        if (color1 + color2) == "greenwhite" or (color1 + color2) == "whitegreen":
            return "green" 

    def draw(self):
        if self.type == "red":
            fill(255,0,0)
        elif self.type == "white":
            fill(255,255,255)
        elif self.type == "green":
            fill(0,255,0)

        ellipse(self.x , self.y , 10, 10)  # some out of bounds bug.
        # if the node has gone once out of bounds, it doesnt show up on intersection... for some reason..
        # This was also solved by taking mouse out of bounds, and by touching with this out of bounds mouse.
        # the intersection works ???!!????!
        # This only happens to node which are at the boudnaries. 
        # Assume you have a node at top boundary and is not getting red.
        # It will surely get red once it goes from top to bottom and collides with other.
        # Same with side. If its not getting red on left. Wait for it to get to the right side. Then it does. Dont know why ???..
        # Somehow changing the mod from here to the move functions fixes this ..!!!
    
    def intersect(self, point):
        distance_between_the_points = math.sqrt( (self.x - point.x)*(self.x - point.x) + (self.y - point.y)*(self.y - point.y) )  # Distance Formula 
        if(distance_between_the_points > 2*5): # (distance_between_the_points > 2*r) : r is 5 see above ellipse
            return False
        else:
            if (self.type == point.type ):
                return
            else:
                color = self.compare(self.type,point.type)
                self.type = color
                point.type = color
            return True

    
points = []    
no_of_points = 600
per_section_no_of_points = no_of_points/3

for i in range(per_section_no_of_points):
    points.append(Point( random.randint(0, 600),random.randint(0, 400),"red"))
for i in range(per_section_no_of_points):
    points.append(Point( random.randint(0, 600),random.randint(0, 400),"green"))
for i in range(per_section_no_of_points):
    points.append(Point( random.randint(0, 600),random.randint(0, 400),"white"))



def setup():
    size(600, 400)

def draw():

    fill(255,255,255)
    background(255,255,255)
    global points
    no_of_points = len(points)
    
    for i in range(no_of_points-1):
        points[i].draw()
        #if mousePressed :
        points[i].move()
    
    points[-1].draw()    
    points[-1].move(mouse_movement=1)
    
    #for i in range(no_of_points):
    #    if (points[i].x > 600 or points[i].y > 400 or points[i].y < 0 or points[i].x < 0 ):
    #        print("here")
    #        print(points[i].x)
    #        print(points[i].y)

    for i in range(no_of_points):
        j = i+1
        while j < no_of_points:
            if i != j:
                points[i].intersect(points[j])
            j = j+1
