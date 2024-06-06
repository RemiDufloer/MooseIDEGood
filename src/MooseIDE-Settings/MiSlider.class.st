Class {
	#name : #MiSlider,
	#superclass : #MiAbstractSlider,
	#instVars : [
		'value',
		'getValueSelector',
		'setValueSelector'
	],
	#category : #'MooseIDE-Settings-Sliders'
}

{ #category : #examples }
MiSlider class >> example [

	<script>
	^ self new open
]

{ #category : #'default values' }
MiSlider >> defaultValue [

	^ 0.5
]

{ #category : #accessing }
MiSlider >> getValueSelector: aString [

	getValueSelector := aString
]

{ #category : #initialization }
MiSlider >> initialize [

	super initialize.
	self value: self defaultValue
]

{ #category : #rendering }
MiSlider >> renderIn: aCanvas [

	self initializeScale.

	aCanvas color: Color transparent.
	aCanvas
		addShape: self backLine;
		addShape: self rangeLine.

	value := self valueFromModel.
	self resizeSlider: aCanvas.

	aCanvas
		when: RSExtentChangedEvent send: #resizeSlider: to: self;
		when: RSMouseClick send: #updateValue: to: self;
		when: RSMouseDragging send: #updateValue: to: self
]

{ #category : #events }
MiSlider >> resizeRangeLine: canvasScale [

	rangeLine
		startPoint: backLine startPoint;
		endPoint: (canvasScale scale: value)
]

{ #category : #accessing }
MiSlider >> setValueSelector: aString [

	setValueSelector := aString
]

{ #category : #events }
MiSlider >> update: aParameter [

	aParameter = getValueSelector ifTrue: [ self updateValue ]
]

{ #category : #events }
MiSlider >> updateValue [

	value := self valueFromModel.
	self resizeSlider: self container
]

{ #category : #events }
MiSlider >> updateValue: evt [

	| canvasScale |

	canvasScale := self resizeCanvasScale: evt.

	value := (canvasScale invert: evt position) x min: 1 max: 0.

	self valueFromModel: value.
	self resizeRangeLine: canvasScale.

	evt signalUpdate
]

{ #category : #accessing }
MiSlider >> value [

	^ value
]

{ #category : #accessing }
MiSlider >> value: aNumber [

	value := aNumber
]

{ #category : #accessing }
MiSlider >> valueFromModel [

	model ifNil: [ ^ self defaultValue ].
	getValueSelector ifNil: [ ^ self defaultValue ].

	^ scale scale: ((model perform: getValueSelector) roundTo: quantum)
]

{ #category : #accessing }
MiSlider >> valueFromModel: aNumber [

	model ifNil: [ ^ self ].
	setValueSelector ifNil: [ ^ self ].
	model
		perform: setValueSelector
		with: ((scale invert: aNumber) roundTo: quantum)
]
