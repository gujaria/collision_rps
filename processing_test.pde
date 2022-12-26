# User Ctrl+Alt+K for running the processing command file
#import numpy

class My_Class():

    def __init__(self):
        self.x = 480
        self.y = 120

A = My_Class()

def setup():

    size(A.x, A.y)

def draw():
    if  mousePressed:
        fill(0)
    else:
        fill(255)
    ellipse(mouseX, mouseY, 80, 80)

print("Hellow world")
