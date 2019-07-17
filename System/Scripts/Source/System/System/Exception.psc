ScriptName System:Exception Extends System:Object Const Native Hidden DebugOnly
{Serves as the base class for system exceptions namespace.

**Remarks**
This class is provided as a means to differentiate between system exceptions and application exceptions.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.exception
* https://docs.microsoft.com/en-us/dotnet/api/system.exception.innerexception
* https://docs.microsoft.com/en-us/dotnet/api/system.systemexception
* https://docs.microsoft.com/en-us/dotnet/api/system.reflection.methodbase
}
import System:Log

; ; Represents errors that occur during application execution.
; Struct ExceptionInfo
; 	string Source = "" ; `Source` Gets or sets the name of the application or the object that causes the error.
; 	string Site = ""   ; `TargetSite` Gets the method that throws the current exception.
; 	string Text = ""   ; `Message` Gets a message that describes the current exception.
; 	string Help = ""   ; `HelpLink` Gets or sets a link to the help file associated with this exception.
; EndStruct

; ExceptionInfo Function NewException(string source = "", string site = "", string text = "", string help = "") Global
; 	ExceptionInfo exception = new ExceptionInfo
; 	exception.Source = source
; 	exception.Site = site
; 	exception.Text = text
; 	exception.Help = help
; 	return exception
; EndFunction

; string Function ExceptionToString(ExceptionInfo value) Global
; 	return value
; EndFunction


; Methods
;---------------------------------------------

bool Function Throw(string script, string member, string text = "") Global DebugOnly
	return System:Debug.WriteMessage(script, member, text)
EndFunction


; Exceptions
;---------------------------------------------

; Members marked as abstract must be implemented by extending classes.
;
; **Remarks**
; The abstract modifier indicates that the member being modified has a missing or incomplete implementation.
; The abstract modifier can be used within functions, events, and full properties.
;
; **See Also**
; * https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/abstract
bool Function Abstract(ScriptObject script, string member, string text = "") Global DebugOnly
	; First parameter is a `ScriptObject` because an instance is required for abstract.
	; Global functions cannot be overriden, thus `Abstract` is not allowed.
	string help = "This member must be overridden with an extending script."
	return Throw(script, "Exception: Abstraction Not Implemented!", member+": The member '"+member+"' MUST be implemented. "+text)
EndFunction


; The exception that is thrown when a requested method or operation is not implemented.
;
; **Remarks**
; The exception is thrown when a particular method is present as a member of a type but is not implemented.
;
; You might choose to throw a *NotImplemented* exception in properties or methods in your own types
; when the that member is still in development and will only later be implemented in production code.
; In other words, a *NotImplemented* exception should be synonymous with "still in development."
;
; **See Also**
; * https://docs.microsoft.com/en-us/dotnet/api/system.notimplementedexception
bool Function ThrowNotImplemented(string script, string member, string text = "") Global DebugOnly
	return Throw(script, "Exception: Not Implemented!", member+": The member '"+member+"' is not implemented yet. "+text)
EndFunction


; The exception that is thrown when a method call is invalid for the object's current state.
;
; **Remarks**
; Throwing *InvalidOperation* is used in cases when the failure to invoke a method is caused by reasons other than invalid arguments.
; Typically, it is thrown when the state of an object cannot support the method call.
;
; **See Also**
; * https://docs.microsoft.com/en-us/dotnet/api/system.invalidoperationexception
bool Function ThrowInvalidOperation(string script, string member, string text = "") Global DebugOnly
	return Throw(script, "Exception: Invalid Operation!", member+": The operation within member '"+member+"' is invalid. "+text)
EndFunction


; The exception that is thrown when an invoked method is not supported.
; This may happen when a method does not support the invoked functionality.
;
; **Remarks**
; Throwing *NotSupported* indicates that no implementation exists for an invoked method.
;
; **See Also**
; * https://docs.microsoft.com/en-us/dotnet/api/system.notsupportedexception
bool Function ThrowNotSupported(string script, string member, string text = "") Global DebugOnly
	return Throw(script, member, text)
EndFunction
