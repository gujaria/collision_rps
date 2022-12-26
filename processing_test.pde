# User Ctrl+Alt+K for running the processing command file
# import numpy
import time

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
    def move(self):
        self.x = self.x + 4
        self.y = self.y - 4
    def draw(self):
        ellipse(self.x % 1200,self.y % 800,10,10)
        self.move()
        
points = []    
points.append(Point(400,400));
points.append(Point(500,400));
    

def setup():
    size(1200, 800)
    
def draw():
    background(0)
    global points
    points[0].draw()
    points[1].draw()


#     if  mousePressed:
#        fill(0)
#    else:
#        fill(255)
#    
#    ellipse(mouseX, mouseY, 10, 10)

print("Hello world")
