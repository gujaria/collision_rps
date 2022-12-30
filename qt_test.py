# User Ctrl+Alt+K for running the processing command file
# import numpy
import time
import math
import random

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
        # if self.type == "red":
        #     fill(255,0,0)
        # elif self.type == "white":
        #     fill(255,255,255)
        # elif self.type == "green":
        #     fill(0,255,0)

        ellipse(self.x ,self.y , 10, 10)  # some out of bounds bug.
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


class Quadtree():

    def __init__(self,limit,x,y,width,height):
        self.limit = limit
        self.my_points = []
        self.sub_devided = False
        self.x = x
        self.y = y
        self.width = width              # This is from centroid.
        self.height = height            # This is from centroid.
                                    # The four subdivision of a tree.
        self.tr = None              # Top-Right
        self.br = None              # Bottom-Right
        self.tl = None              # Top-Left
        self.bl = None              # Bottom-Left

#        self.draw()                   # Draw this quad 
    def subdevide(self,quadtree):
        width = self.width/2
        height = self.height/2

        self.tl = Quadtree(self.limit, self.x-width, self.y + height, width, height)
        self.tr = Quadtree(self.limit, self.x+width, self.y + height, width, height)
        self.bl = Quadtree(self.limit, self.x-width, self.y - height, width, height)
        self.br = Quadtree(self.limit, self.x+width, self.y - height, width, height)
        self.sub_devided = True
        # Make 4 trees as a part of the class.
        pass

    def isinside(self,Point):
        return (Point.x < self.x + self.width)  and (Point.x > self.x - self.width) and (Point.y < self.y + self.height)  and (Point.y > self.y - self.height) 
    
    def insert(self,Point):
        self.draw()
        need_to_subdevide = False
        if self.sub_devided == False:
            has_capacity = len(self.my_points) < self.limit
            if has_capacity is False:
                need_to_subdevide = True
            if has_capacity and self.isinside(Point):
                self.my_points.append(Point)
                return True
        
        if need_to_subdevide == True or self.sub_devided == True :
            if need_to_subdevide:
                self.subdevide(self)
                ## The below for loop devides the existing points into the subdevision.
                for point in self.my_points:
                    if self.tr.isinside(point): self.tr.my_points.append(point)            
                    elif self.br.isinside(point): self.br.my_points.append(point)              
                    elif self.tl.isinside(point): self.tl.my_points.append(point)              
                    elif self.bl.isinside(point): self.bl.my_points.append(point)   
                self.my_points = []           
    
            # Once the existing points have been subdevided, new Point in then inserted into the subdevision.
            if self.tr.insert(Point): return True           
            elif self.br.insert(Point): return True              
            elif self.tl.insert(Point): return True              
            elif self.bl.insert(Point): return True              

    def draw(self):
        rectMode(CENTER)
        rect(self.x, self.y , self.width*2 ,self.height*2 )
         
    def querry(self,some_sort_of_rectanglular_range):
        pass

QT = Quadtree(4,600,300,1200/2,600/2)
my_points=[]
def setup():
    size(1200, 600)
'''
Keep in mind that the co-ordinate system is different for processing, and for what you have programmed for.
'''
def draw():
    global QT
    global my_points
    #fill(255,255,255)
    #rect(0,0,600/2,400/2)   
    #background(255,255,255)
    stroke(0, 0, 255)
    if mousePressed:
        my_point = Point(mouseX,mouseY,"red")
        my_points.append(my_point)
        QT.insert(my_point)   
        stroke(255, 0, 0) 
        for point in my_points:
            point.draw()

    print(len(my_points))
    # Once I click it should create a point there and also a quadtree.
    # If click create a point
    # Pass the point to the quadtree
    # See how it creates a quad tree.    
    
