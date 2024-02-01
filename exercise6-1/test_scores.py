#!/usr/bin/env python3

def display_welcome():
    print("The Test Scores program")
    print("Enter 'x' to exit")
    print("")

def get_scores():
    scores = []

    while True:
        score = input("Enter test score: ")
        if score == "x":
            return  scores
        else:
            score = int(score)
            if score >= 0 and score <= 100:
                scores.append(score)
            else:
                print("Test score must be from 0 through 100. " +
                      "Score discarded. Try again.")

def process_scores(scores):
    # calculate total score
    total = 0
    for score in scores:
        total += score

    # calculate average score
    average = round(total / len(scores))

    # calculate low score
    low_score = min(scores)

    #calculate high score
    high_score = max(scores)

    #calculate median score (had to look this one up online and try to apply it here cause I was not getting it XD)
    # https://www.geeksforgeeks.org/finding-mean-median-mode-in-python-without-libraries/
    
    how_many = len(scores) 
    scores.sort() 
     
    if how_many % 2 == 0: 
        median1 = scores[how_many//2] 
        median2 = scores[how_many//2 - 1] 
        median = (median1 + median2)/2
    else: 
        median = scores[how_many//2]
                
    # format and display the result
    print()
    print("Score total:       ", total)
    print("Number of Scores:  ", len(scores))
    print("Average Score:     ", average)
    print("Low Score:         ", low_score)
    print("High Score:        ", high_score)
    print("Median Score:      ", median)

def main():
    display_welcome()
    scores = get_scores()
    process_scores(scores)
    print("")
    print("Bye!")

# if started as the main module, call the main function
if __name__ == "__main__":
    main()


