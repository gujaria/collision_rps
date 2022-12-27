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
    
    def move(self, movement = None,x_c = None,y_c= None):
        if movement == "random":    
            self.x = (self.x + random.randint(-2, 2)) % 600
            self.y = (self.y + random.randint(-2, 2)) % 400
        elif movement == "mouse":
            self.x = mouseX
            self.y = mouseY
        elif movement == "centroid":
            self.x = 0.01 *(x_c-self.x) + self.x
            self.y = 0.01 *(y_c-self.y) + self.y

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
no_of_points = 300
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
    
    centroid_red_x = []
    centroid_green_x = []
    centroid_white_x = []
    
    centroid_red_y = []
    centroid_green_y = []
    centroid_white_y = []
    
    # 1 for now so that there is no devide by zero error
    green_points = 1
    red_points = 1
    white_points = 1
    
    for i in range(no_of_points):
        point = points[i] 
        if point.type == "red":
            centroid_red_x.append(point.x)
            centroid_red_y.append(point.y)
        elif point.type == "green":
            centroid_green_x.append(point.x)
            centroid_green_y.append(point.y)
        elif point.type == "white":
            centroid_white_x.append(point.x)
            centroid_white_y.append(point.y)
              


    for i in range(no_of_points-1):
        #if mousePressed :
        if points[i].type == "red" :
            x =  sum(centroid_red_x)/len(centroid_red_x)
            y =  sum(centroid_red_y)/len(centroid_red_y)
        elif points[i].type == "green" :
            x =  sum(centroid_green_x)/len(centroid_green_x)
            y =  sum(centroid_green_y)/len(centroid_green_y)
        elif points[i].type == "white" :
            x =  sum(centroid_white_x)/len(centroid_white_x)
            y =  sum(centroid_white_y)/len(centroid_white_y)
        points[i].move(movement = "centroid", x_c = x, y_c = y)
        points[i].draw()

    points[-1].draw()    
    points[-1].move("mouse")
    #print(x)
    #print(y)
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
