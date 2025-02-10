extends Node2D
@onready var main: Node = $".."
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if main.day == 1:
		if main.slackMessage == 0:
			label.text = ("Andy -> Hey bro, it’s Andy. 
			I hope you took the advice I gave you last week and 
			have a nice cold refreshing beer next to you right now. ")
		if main.slackMessage == 1:
			label.text = ("Andy -> This job is stressful! 
			Taking a sip every now and then helps take the edge off. 
			If you stay sober you’ll get too angry and 
			you might just quit right there on the spot, hahaha. 
			I’ve seen it happen before.")
		elif main.slackMessage == 2:
			label.text = ("Andy -> Be careful when you pour 
			up your beer. If it overflows and spills on your computer, 
			it’ll cause an electrical surge. It hyper charges your 
			computer and things get real fast.")
		elif main.slackMessage == 3:
			label.text = ("Andy -> Oh, I forgot to tell you. 
			Having some beer every now and then is good, 
			but the trick is to ride a perfect buzz throughout 
			the entire work day. If you drink too much, you’ll 
			get wasted and work gets a lot harder. 
			Things start looking funny. Trust me.")
		elif main.slackMessage == 4:
			label.text = ("Andy -> gOD, I’m feeling it bro. 
			Thank god the day IS almost doen")
		elif main.slackMessage >= 5:
			label.text = ("No new messages.")
	elif main.day == 2:
		if main.slackMessage == 0:
			label.text = ("Andy -> Happy drinking today man!  ")
		elif main.slackMessage == 1:
			label.text = ("Andy -> The cool thing about drinking 
			on the job is it’s like a long pregame so you can 
			hit the bars right after.")
		elif main.slackMessage == 2:
			label.text = ("Andy -> Boss put me on this 
			weird chicken project.")
		elif main.slackMessage == 3:
			label.text = ("Andy -> Have I ever told you about 
			the guy you replaced. It’s a long story.")
		elif main.slackMessage == 4:
			label.text = ("Andy -> Dude, what were just 
			talking about? I’m feeling it, lamo.")
		elif main.slackMessage == 5:
			label.text = ("I miss him")
		elif main.slackMessage >= 6:
			label.text = ("No new messages.")
	elif main.day == 3:
		if main.slackMessage == 0:
			label.text = ("Andy -> This chicken stuff is nuts.")
		elif main.slackMessage == 1:
			label.text = ("Andy -> You remind me of him. 
			The last guy. He was a visionary.")
		elif main.slackMessage == 2:
			label.text = ("Andy -> He was the one that told me 
			to start drinking on the job. At first I was hesitant, 
			but now I can’t stop. ")
		elif main.slackMessage == 3:
			label.text = ("Andy -> I get so excited for work now. 
			I literally shake and get chills before I log on. Lol.")
		elif main.slackMessage == 4:
			label.text = ("Andy -> When he left, I knew I needed 
			to pass on the tradition. Glad you are on the squad bro.")
		elif main.slackMessage == 5:
			label.text = ("I miss him")
		elif main.slackMessage >= 6:
			label.text = ("No new messages.")
			
