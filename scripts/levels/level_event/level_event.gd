extends Resource
class_name LevelEvent

@export var id: int
@export var event_type: EventType
@export var pattern: Pattern = preload("res://aseets/resources/pattern.tres")

enum EventType {
	START,
	STOP
}
