# User Ctrl+Alt+K for running the processing command file
#import numpy
def setup():
    size(480, 120)
    
def draw():
    if  mousePressed:
        fill(0)
    else:
        fill(255)
    ellipse(mouseX, mouseY, 80, 80)

print("Hellow world")
