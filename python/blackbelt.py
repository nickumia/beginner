
formsKnown = 0
daysAttended = 0
rank = ""

formsKnown = int(input("Enter the number of forms you know: "))
daysAttended = int(input("Enter the number of days attended: "))

if formsKnown > 14:
	rank = "black belt"
elif formsKnown >10 and daysAttended > 500:
	rank = "brown belt"
elif formsKnown > 10 and daysAttended > 20:
	rank = "green belt"
elif formsKnown > 5 and daysAttended > 50:
	rank = "blue belt"
else:
	rank = "white belt"

print("Your rank is %s" % (rank))