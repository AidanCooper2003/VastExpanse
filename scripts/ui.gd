extends CanvasLayer
class_name UI

var _jobs = {}
var _purchaseables = {}
var _resources = {}

var _guideToggled := true

@export var _uiManager: UIManager

@export var jobsContainer: Node
@export var technologyContainer: Node
@export var buildingsContainer: Node
@export var resourcesContainer: Node
@export var conversionLabel : Node
@export var turnLabel : Node
@export var endScoreLabel : Node
@export var endTurnButton : Button
@export var restartButton : Button
@export var jobInfoLabel : RichTextLabel
@export var purchaseInfoLabel : RichTextLabel
@export var statsInfoLabel : RichTextLabel
@export var goalInfoLabel : RichTextLabel
@export var showGuideButton : Button



# At some point, make jobs, purchasables, and resources interfaces so this
# doesn't use repeated code.
func _ready():
	for j in jobsContainer.get_children():
		_jobs[j.get_job_title()] = j
	for t in technologyContainer.get_children():
		_purchaseables[t.get_purchasable_name()] = t
	for b in buildingsContainer.get_children():
		_purchaseables[b.get_purchasable_name()] = b
	for r in resourcesContainer.get_children():
		_resources[r.get_resource_name()] = r
		print("found resource " + r.get_resource_name())

func update_job(jobName: String, hired: int, max: int, description: String):
	_jobs[jobName].update_job_count(hired, max)
	_jobs[jobName].update_job_description(description)
	
func update_purchasable(purchaseableName: String, cost: int, count: int, description: String, resourceCost: String):
	_purchaseables[purchaseableName]._update_rank_label("Rank: " + str(count))
	_purchaseables[purchaseableName]._update_cost_label(resourceCost + ": " + str(cost))
	_purchaseables[purchaseableName]._update_description_label(description)


# Population uses current as max population, and income as hired population. Temporary workaround.
func update_resources(resourceName: String, current: int, income: int):
	if resourceName != "Population":
		_resources[resourceName].update_text(resourceName + ": " + str(current) + " / +" + str(income))
	else:
		_resources[resourceName].update_text("Population: " + str(income) + " / " + str(current))
		
func update_conversion_label(cost: int, growth: int):
	conversionLabel.text = "Population Growth\nCost: " + str(cost) + "\nGrowth: " + str(growth)

func job_hire(jobName: String, count: int):
	_uiManager.hire_job(jobName, count)

func job_fire(jobName: String, count: int):
	_uiManager.fire_job(jobName, count)
	
func end_turn():
	_uiManager.end_turn()
	_uiManager.increment_turn()
	_uiManager.do_updates()

func make_purchase(purchaseName: String):
	_uiManager.make_purchase(purchaseName)
	_uiManager.do_updates()
	
func update_turn_label(turnNumber : int, endTurn : int):
	turnLabel.text = "Turn: " + str(turnNumber) + "/" + str(endTurn)
	
func update_end_score_label(techScore : int, popScore : int, buildingScore : int, totalScore : int):
	endScoreLabel.text = "Score from techs: " + str(techScore) + "\n" + "Score from population: " + str(popScore) + "\n" + "Score from buildings: " + str(buildingScore) + "\n" + "TOTAL SCORE: " + str(totalScore)
	endTurnButton.disabled = true
	restartButton.visible = true
	showGuideButton.disabled = true
	if _guideToggled:
		toggle_guide()
	
func restart_game():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func toggle_guide():
	jobInfoLabel.visible = !jobInfoLabel.visible
	purchaseInfoLabel.visible = !purchaseInfoLabel.visible
	statsInfoLabel.visible = !statsInfoLabel.visible
	goalInfoLabel.visible = !goalInfoLabel.visible
	_guideToggled = !_guideToggled
