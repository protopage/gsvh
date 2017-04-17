#Document Setup
document.body.style.cursor = "auto"
Framer.Extras.Hints.disable()
Framer.Extras.ShareInfo.disable()
Framer.Extras.Preloader.enable()
# Sketch
sketch = Framer.Importer.load("imported/Global Sections Version History @1x")

{artboard, versionHistoryBar, topBarGlobal, topBar, scrollers, backZone, versionActive, version1Zone, version1Hover, version1, version2Zone, version2Hover, version2, version3Zone, version3Hover, version3, version4Zone, version4Hover, version4, version5Zone, version5Hover, version5, version6Zone, version6Hover, version6, editState, section, sectionEdit, sectionControl, sectionControlEdit, sectionHover, moreShit, dropdown, toolbar, editClick, editingToolbar1, editingToolbar2, dropdownEdit, moreShitEdit, editSection1, editSection2, editSection3, editOpacity, editClick1, versionClick, toolbarEdit, btnCancel1, btnCancel2, btnApply1, btnApply2, bg3, toolbarEditBack} = sketch

scroll = ScrollComponent.wrap(scrollers)
scroll.scrollVertical = true
scroll.scrollHorizontal = false
scroll.mouseWheelEnabled = true
Canvas.onResize ->
	scroll.size = Canvas.size
scroll.content.draggable.enabled = false

editState.visible = false

#Toolbar Hovers and Clicks

shits = [moreShit, sectionControlEdit]
menus = [dropdown, dropdownEdit]
hovers = [section, sectionEdit]
toolbars = [sectionControl, sectionControlEdit]
sections = [section, sectionEdit]

create = (index) ->
	menus[index].visible = false
	toolbars[index].opacity = 0
	hovers[index].on "mouseenter", ->
		toolbars[index].opacity = 1
	hovers[index].on "mouseleave", ->
		toolbars[index].opacity = 0
		menus[index].visible = false
	shits[index].onClick ->
		if menus[index].visible == false
			menus[index].visible = true
		else
			menus[index].visible = false
for i in [0...hovers.length]
	create(i)


versionZone = [version1Zone, version2Zone, version3Zone, version4Zone, version5Zone, version6Zone]
version = [version1, version2, version3, version4, version5, version6]
versionHover = [version1Hover, version2Hover, version3Hover, version4Hover, version5Hover, version6Hover]

createVersionHovers = (index) ->
	versionHover[i].visible = false
	versionZone[index].on "mouseenter", ->
		versionHover[index].visible = true
		version[index].visible = false
		document.body.style.cursor = "pointer"
	versionZone[index].on "mouseleave", ->
		version[index].visible = true
		versionHover[index].visible = false
		document.body.style.cursor = "auto"

for i in [0...version.length]
	createVersionHovers(i)

sectionHover.onClick ->
	if dropdown.visible is true
		dropdown.visible = false

# Edit State

bg3.visible = false
versionHistoryBar.visible = false


sectionEdit.originY = 0
sectionEdit.originX = 0.5


topBarGlobal.visible = false
editState.visible = false
toolbarEdit.visible = false
editingToolbar1.opacity = 0
editingToolbar1.scale = 0.9
editingToolbar2.visible = false

sectionEdit.shadowColor = "rgba(0,0,0,0)"

rise = new Animation sectionEdit,
	scale: 1.1

descend = new Animation sectionEdit,
	scale: 1

toolbarFadeOut1 = new Animation editingToolbar1,
	opacity: 0
	scale: 0.9

toolbarFadeOut2 = new Animation editingToolbar2,
	opacity: 0
	scale: 0.9

toolbarFadeIn1 = new Animation editingToolbar1,
	opacity: 1
	scale: 1

toolbarFadeIn2 = new Animation editingToolbar2,
	opacity: 1
	scale: 1

shadowUp = new Animation sectionEdit,
	shadowBlur: 30
	shadowColor: "rgba(0,0,0,0.4)"

shadowDown = new Animation sectionEdit,
	shadowBlur: 0
	shadowColor: "rgba(0,0,0,0)"

editClick1.onClick ->
	
	editingToolbar1.visible = true
	editingToolbar2.visible = false
	editState.visible = true
	topBar.visible = false
	topBarGlobal.visible = true
	rise.start()
	toolbarFadeIn1.start()
	toolbarFadeIn2.start()
	shadowUp.start()
	

btnCancel1.onClick ->
	toolbarEdit.visible = false
	topBarGlobal.visible = false
	versionHistoryBar.visible = false
	topBar.visible = true
	descend.start()
	toolbarFadeOut1.start()
	shadowDown.start()
	if editSection3.visible is true
		bg3.visible = true
	else 
		bg3.visible = false

btnCancel2.onClick ->
	editingToolbar2.visible = false
	editingToolbar1.visible = true

descend.onAnimationEnd ->
	editState.visible = false

btnApply1.onClick ->
	editingToolbar1.visible = false
	editingToolbar2.visible = true

btnApply2.onClick ->
	toolbarEdit.visible = false
	descend.start()
	toolbarFadeOut2.start()
	editingToolbar1.visible = true
	toolbarFadeOut1.start()
	shadowDown.start()
	if editSection3.visible is true
		bg3.visible = true
	else 
		bg3.visible = false


versionClick.onClick ->
	versionHistoryBar.visible = true

backZone.onClick ->
	versionHistoryBar.visible = false


editSection3.visible = false
editSection2.visible = false

editSection1.onClick ->
	editSection2.visible = true
	editSection1.visible = false

editSection2.onClick ->
	editSection3.visible = true
	editSection2.visible = false

version1Zone.onClick ->
	editingToolbar2.opacity = 1
	editingToolbar2.visible = false
	editSection1.visible = true
	editSection3.visible = false


editClick.onClick ->
	toolbarEdit.visible = true

toolbarEditBack.onClick ->
	toolbarEdit.visible = false