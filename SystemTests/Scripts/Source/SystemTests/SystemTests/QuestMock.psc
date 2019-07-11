ScriptName SystemTests:QuestMock Extends System:Quest
import System:Exception


Group Properties
	Quest Property MyQuest Auto Const Mandatory
EndGroup

; Constructor
;---------------------------------------------

Event OnInit()
	RegisterForQuestInit(QUST)
	RegisterForQuestShutdown(QUST)
EndEvent

; @overrides
Quest Function QUST()
	return MyQuest
EndFunction


; Events
;---------------------------------------------

Event OnQuestInit()
	System:Log.WriteLine("System", self, "OnQuestInit")
EndEvent


Event OnQuestShutdown()
	System:Log.WriteLine("System", self, "OnQuestShutdown")
EndEvent
