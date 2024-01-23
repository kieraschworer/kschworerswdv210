#!/usr/bin/env python3

# display a welcome message
print("The Miles Per Gallon program")
print()

choice = "y"
while choice.lower() == "y":

    # get input from the user
    miles_driven = float(input("Enter miles driven:         "))
    gallons_used = float(input("Enter gallons of gas used:  "))
    gallon_cost = float(input("Enter cost per gallon:  "))

    if miles_driven <= 0:
        print("Miles driven must be greater than zero. Please try again.")
    elif gallons_used <= 0:
        print("Gallons used must be greater than zero. Please try again.")
    elif gallon_cost <=0:
        print("Gallons cost must be greater than zero. Please try again.")
    else:
        # calculate and display miles per gallon
        mpg = round(miles_driven / gallons_used, 2)
        total_cost = round(gallons_used * gallon_cost, 2)
        cost_per_mile = round(gallons_used / miles_driven * gallon_cost, 1)
        print()
        print("Miles Per Gallon:          ", mpg)
        print("Total Gas Cost:            ", total_cost)
        print("Cost Per Mile:             ", cost_per_mile)
        print()
        
    choice = input("Get entries for another trip (y/n)? ")

print()
print("Bye!")



