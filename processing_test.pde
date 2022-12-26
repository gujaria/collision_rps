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
            self.x = self.x + random.randint(-10, 10)
            self.y = self.y + random.randint(-10, 10)
        else:
            self.x = mouseX
            self.y = mouseY
    
    def draw(self):
        ellipse(self.x % 1200, self.y % 800, 10, 10)
    
    def intersect(self, point):
        distance_between_the_points = math.sqrt( (self.x - point.x)*(self.x - point.x) + (self.y - point.y)*(self.y - point.y) )  # Distance Formula 
        if(distance_between_the_points > 2*5): # (distance_between_the_points > 2*r) : r is 5 see above ellipse
            return False
        else:
            fill(255,0,0)
            self.draw()
            point.draw()
            return True


points = []    

for i in range(500):
    points.append(Point( random.randint(0, 1200),random.randint(0, 800)))   

def setup():
    size(1200, 800)

def draw():

    fill(255,255,255)
    background(0)
    global points
    no_of_points = len(points)
    
    for i in range(no_of_points-1):
        points[i].draw()
        if mousePressed :
            points[i].move()
    
    points[-1].draw()    
    points[-1].move(mouse_movement=1)
    
    for i in range(no_of_points):
        j = i
        while j < no_of_points:
            if i != j:
                points[i].intersect(points[j])
            j = j+1
