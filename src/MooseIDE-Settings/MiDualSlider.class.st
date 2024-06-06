Class {
	#name : #MiDualSlider,
	#superclass : #MiAbstractSlider,
	#instVars : [
		'minValue',
		'maxValue',
		'minButton',
		'maxButton',
		'getMin',
		'setMin',
		'getMax',
		'setMax'
	],
	#category : #'MooseIDE-Settings-Sliders'
}

{ #category : #examples }
MiDualSlider class >> example [

	<script>
	^ self new open
]

{ #category : #'default values' }
MiDualSlider >> defaultMaxValue [

	^ 0.6
]

{ #category : #'default values' }
MiDualSlider >> defaultMinValue [

	^ 0.4
]

{ #category : #accessing }
MiDualSlider >> getMax: anObject [

	getMax := anObject
]

{ #category : #accessing }
MiDualSlider >> getMin: anObject [

	getMin := anObject
]

{ #category : #highlighting }
MiDualSlider >> highlight: evt [

	| paint |

	evt interaction
		record: evt shape
		selector: #paint
		value: evt shape paint.
	paint := self rangePaint.
	paint
		start: 0 @ evt shape height / -2;
		stop: 0 @ evt shape height / 2.
	evt shape color: paint
]

{ #category : #highlighting }
MiDualSlider >> hightlightInteraction [

	^ RSHighlightable new
		  when: RSHighlightEvent send: #highlight: to: self;
		  when: RSUnHighlightEvent send: #unhighlight: to: self;
		  yourself
]

{ #category : #initialization }
MiDualSlider >> initialize [

	super initialize.
	self
		minValue: self defaultMinValue;
		maxValue: self defaultMaxValue
]

{ #category : #buttons }
MiDualSlider >> maxButton [

	^ maxButton := self newButton
		when: RSMouseDragging send: #updateMaxValue: to: self;
		when: RSMouseDragEnd send: #updateMaxValueUp: to: self;
		yourself
]

{ #category : #accessing }
MiDualSlider >> maxValue [

	^ maxValue
]

{ #category : #accessing }
MiDualSlider >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : #public }
MiDualSlider >> maxValueFromModel [

	model ifNil: [ ^ self defaultMaxValue ].
	getMax ifNil: [ ^ self defaultMaxValue ].
	^ scale scale: ((model perform: getMax) roundTo: quantum)
]

{ #category : #public }
MiDualSlider >> maxValueFromModel: aNumber [

	model ifNil: [ ^ self ].
	setMax ifNil: [ ^ self ].
	model
		perform: setMax
		with: ((scale invert: aNumber) roundTo: quantum)
]

{ #category : #buttons }
MiDualSlider >> minButton [

	^ minButton := self newButton
		when: RSMouseDragging send: #updateMinValue: to: self;
		when: RSMouseDragEnd send: #updateMinValueUp: to: self;
		yourself
		
]

{ #category : #accessing }
MiDualSlider >> minValue [

	^ minValue
]

{ #category : #accessing }
MiDualSlider >> minValue: aNumber [

	minValue := aNumber
]

{ #category : #public }
MiDualSlider >> minValueFromModel [

	model ifNil: [ ^ 0.4 ].
	getMin ifNil: [ ^ 0.4 ].
	^ scale scale: ((model perform: getMin) roundTo: quantum)
]

{ #category : #public }
MiDualSlider >> minValueFromModel: aNumber [

	model ifNil: [ ^ self ].
	setMin ifNil: [ ^ self ].
	model
		perform: setMin
		with: ((scale invert: aNumber) roundTo: quantum)
]

{ #category : #buttons }
MiDualSlider >> newButton [

	| size paint |

	paint := self backPaint.
	size := 20.
	paint
		start: 0 @ size / -2;
		stop: 0 @ size / 2.

	^ RSEllipse new
		  addInteraction: self hightlightInteraction;
		  withBorder;
		  color: paint;
		  size: size;
		  yourself
]

{ #category : #rendering }
MiDualSlider >> renderIn: aCanvas [

	aCanvas
		color: Color transparent;
		addShape: self backLine;
		addShape: self rangeLine;
		addShape: self minButton;
		addShape: self maxButton.

	self initializeScale.

	minValue := self minValueFromModel.
	maxValue := self maxValueFromModel.

	self resizeSlider: aCanvas.

	aCanvas
		when: RSExtentChangedEvent send: #resizeSlider: to: self;
		when: RSMouseClick send: #updateCloserPoint: to: self
]

{ #category : #events }
MiDualSlider >> resizeRangeLine: canvasScale [

	| minValuePoint maxValuePoint |

	minValuePoint := canvasScale scale: minValue.
	maxValuePoint := canvasScale scale: maxValue.

	rangeLine
		startPoint: minValuePoint;
		endPoint: maxValuePoint.

	minButton position: minValuePoint.
	maxButton position: maxValuePoint
]

{ #category : #accessing }
MiDualSlider >> setMax: anObject [

	setMax := anObject
]

{ #category : #accessing }
MiDualSlider >> setMin: anObject [

	setMin := anObject
]

{ #category : #highlighting }
MiDualSlider >> unhighlight: evt [

	evt interaction restore: evt shape selector: #paint
]

{ #category : #events }
MiDualSlider >> updateCloserPoint: evt [

	| dist1 dist2 button |

	dist1 := evt position distanceTo: minButton position.
	dist2 := evt position distanceTo: maxButton position.
	button := dist1 < dist2
		          ifTrue: [ minButton ]
		          ifFalse: [ maxButton ].
	button announce: (RSMouseDragging new
			 position: evt position;
			 step: evt position - minButton position;
			 yourself).
	button announce: RSMouseDragEnd new.
	evt signalUpdate
]

{ #category : #events }
MiDualSlider >> updateMaxValue: evt [

	| newValue w |

	w := evt canvas extent x - self lineGap.
	newValue := evt position x + (w / 2) / w.
	newValue := newValue min: 1 max: minValue.
	maxValue := newValue.
	self resizeSlider: evt.
	evt signalUpdate
]

{ #category : #events }
MiDualSlider >> updateMaxValueUp: evt [

	self maxValueFromModel: maxValue
]

{ #category : #events }
MiDualSlider >> updateMinValue: evt [

	| newValue w |

	w := evt canvas extent x - self lineGap.
	newValue := evt position x + (w / 2) / w.
	newValue := newValue min: maxValue max: 0.
	minValue := newValue.

	self resizeSlider: evt.
	evt signalUpdate
]

{ #category : #events }
MiDualSlider >> updateMinValueUp: evt [

	self minValueFromModel: minValue
]

{ #category : #update }
MiDualSlider >> updateValue [
	minValue := self minValueFromModel.
	maxValue := self maxValueFromModel.
	self resizeSlider: self container.
	self container signalUpdate.
]
