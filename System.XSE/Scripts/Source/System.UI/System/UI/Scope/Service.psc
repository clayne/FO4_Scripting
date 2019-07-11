ScriptName System:UI:Scope:Service Extends System:UI:Scope:ServiceType
{The scope menu service provides backend for the scope menu.}
import System:Log
import System:UI:Scope:Menu

Actor Player
bool BreathPressed = false
bool Interrupted = false


; Events
;---------------------------------------------

Event OnInit() ; TODO: This only happens once per object life time.
	RegisterForQuestInit(QUST)
	RegisterForQuestShutdown(QUST)
EndEvent


; TODO: Use the game reload event
Event OnQuestInit()
	Player = Game.GetPlayer()
	Player.AddSpell(SystemXSE_UI_ScopeBreathEvent)
	RegisterForMenuOpenCloseEvent(Menu.Name)

	RegisterForGameReload(self)
	OnGameReload()
EndEvent


Event OnGameReload()
	RegisterForMenuOpenCloseEvent(Menu.Name)
	WriteLine("System", ToString(), "OnGameReload")
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	BreathPressed = false
	If (opening)
		RegisterForKey(BreathKey)
	Else
		UnregisterForKey(BreathKey)
	EndIf

	OpenCloseEventArgs e = new OpenCloseEventArgs
	e.Opening = opening
	self.SendOpenCloseEvent(e)
EndEvent


Event OnKeyDown(int keyCode)
	BreathPressed = true
	BreathEventArgs e = new BreathEventArgs
	e.Breath = BreathHeld
	self.SendBreathEvent(e)
EndEvent


Event OnKeyUp(int keyCode, float time)
	BreathPressed = false
	If (Interrupted)
		Interrupted = false
	Else
		BreathEventArgs e = new BreathEventArgs
		e.Breath = BreathReleased
		self.SendBreathEvent(e)
	EndIf
EndEvent


; Methods
;---------------------------------------------

Function SendOpenCloseEvent(OpenCloseEventArgs e)
	If (e)
		var[] arguments = new var[1]
		arguments[0] = e
		Menu.SendCustomEvent("OpenCloseEvent", arguments)
	Else
		WriteUnexpectedValue("System", self, "SendOpenCloseEvent", "e", "The argument cannot be none.")
	EndIf
EndFunction


Function SendBreathEvent(BreathEventArgs e)
	If (Menu.IsOpen)
		If (e)
			If (e.Breath == BreathInterrupted)
				Interrupted = true
			EndIf
			var[] arguments = new var[1]
			arguments[0] = e
			Menu.SendCustomEvent("BreathEvent", arguments)
		Else
			WriteUnexpectedValue("System", self, "SendBreathEvent", "e", "The argument cannot be none.")
		EndIf
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return "[System:UI:Scope:Service]"
EndFunction


; Properties
;---------------------------------------------

Group Scopes
	System:UI:Scope:Menu Property Menu Auto Const Mandatory
EndGroup

Group Breath
	Spell Property SystemXSE_UI_ScopeBreathEvent Auto Const Mandatory
	ActorValue Property ActionPoints Auto Const Mandatory

	int Property BreathHeld = 0 AutoReadOnly
	int Property BreathReleased = 1 AutoReadOnly
	int Property BreathInterrupted = 2 AutoReadOnly

	int Property BreathKey = 164 AutoReadOnly

	bool Property IsBreathKeyDown Hidden
		bool Function Get()
			return BreathPressed
		EndFunction
	EndProperty

	bool Property HasBreath Hidden
		bool Function Get()
			return Player.GetValue(ActionPoints) > 0
		EndFunction
	EndProperty
EndGroup
